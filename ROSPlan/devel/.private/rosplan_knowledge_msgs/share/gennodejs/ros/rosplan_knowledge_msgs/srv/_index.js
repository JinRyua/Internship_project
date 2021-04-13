
"use strict";

let KnowledgeUpdateService = require('./KnowledgeUpdateService.js')
let GetAttributeService = require('./GetAttributeService.js')
let GetDomainOperatorService = require('./GetDomainOperatorService.js')
let AddWaypoint = require('./AddWaypoint.js')
let RemoveWaypoint = require('./RemoveWaypoint.js')
let GetMetricService = require('./GetMetricService.js')
let GetDomainPredicateDetailsService = require('./GetDomainPredicateDetailsService.js')
let KnowledgeQueryService = require('./KnowledgeQueryService.js')
let GetDomainNameService = require('./GetDomainNameService.js')
let GetDomainAttributeService = require('./GetDomainAttributeService.js')
let GetDomainOperatorDetailsService = require('./GetDomainOperatorDetailsService.js')
let GetDomainTypeService = require('./GetDomainTypeService.js')
let CreatePRM = require('./CreatePRM.js')
let KnowledgeUpdateServiceArray = require('./KnowledgeUpdateServiceArray.js')
let GetInstanceService = require('./GetInstanceService.js')
let GenerateProblemService = require('./GenerateProblemService.js')

module.exports = {
  KnowledgeUpdateService: KnowledgeUpdateService,
  GetAttributeService: GetAttributeService,
  GetDomainOperatorService: GetDomainOperatorService,
  AddWaypoint: AddWaypoint,
  RemoveWaypoint: RemoveWaypoint,
  GetMetricService: GetMetricService,
  GetDomainPredicateDetailsService: GetDomainPredicateDetailsService,
  KnowledgeQueryService: KnowledgeQueryService,
  GetDomainNameService: GetDomainNameService,
  GetDomainAttributeService: GetDomainAttributeService,
  GetDomainOperatorDetailsService: GetDomainOperatorDetailsService,
  GetDomainTypeService: GetDomainTypeService,
  CreatePRM: CreatePRM,
  KnowledgeUpdateServiceArray: KnowledgeUpdateServiceArray,
  GetInstanceService: GetInstanceService,
  GenerateProblemService: GenerateProblemService,
};
