Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D672606A31A
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=me+nUwhI;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b0xrHZBt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4cgA7XI2b8qExk0OIxF80xazAUFwJtZ3ZYM9ngvMGXE=; b=me+nUwhIzRIPFq0DMJIXWGMAa5
	jhTSZOffZ0MzFAIHjC9Pp6NFioaaH5/IrqGYtvXSmA6hlb+26Fl5D+LO54ongq/EighIEny7ptl8M
	/xvd1uOxfkLbIubBYjb001R0iTEMhLLOaWMZD6+Rko08XdXe0NEDBJtK4iDtS3/p+inY3EYgQdVJn
	l0FxWvaVVFXFu15PO+28JdqOxWwPBkckqIai6oyLb8mAqOA+v0qyVxT6ZGYv5O8KJcq+zatXKHQH0
	uFhfGluFqVkwGrmf5sLRKOBEyKzTyl69ZErfFllv4G62ITqJeq4f87UNReudlJHfcI45DA9CNVrts
	9rVq5Esg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJTni-0000000BdOn-2ooG;
	Wed, 21 Oct 2026 10:44:06 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJTng-0000000BdOH-0KIW
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 10:44:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792579444; x=1824115444;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=id24djkpTiIywili9vrSIKKdtX5HU5KUdngVqC9Mc4E=;
  b=b0xrHZBt/0bZh0jqBFOdShk3RgKfmfMPd5ewjnf0lOF+jyz/U8yB7xWr
   raN5/ts1fthfZ4DlO5mPxx7TDr+VSMFoquKv3uuPVGiOJse800NafcKh2
   xjja1j+2vlTA4D0vlKdetEUGd1FWlttEDe6K73sN4hNq2vggM7VF+wt9n
   HoNJoBiC2j51Z1ZMZS9drPuvSDfO72HyfGU+IgzocJ2nmRhNZmUzUN4r4
   hdeWWgwEQV/Tm7hZ+hPoVIngkf6uWNcKKUNE5Q1QEXWteft8YopGRBxcV
   j8+DgMoasvxlQIVoYxpvWEKEqtpGvLh4ywLCblSpK5d7OIA/WpgUkpzcQ
   A==;
X-CSE-ConnectionGUID: iOIyRjx7R6ygKTpO5/buNg==
X-CSE-MsgGUID: O0XNt5f5R123DLRLYVAosg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1198939"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1198939"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 03:44:02 -0700
X-CSE-ConnectionGUID: 7jAvJpcbT5aGWOEwnrcvAg==
X-CSE-MsgGUID: XbvptX6NRDCXc/viCIaotQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3387538"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 03:44:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:44:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 03:44:02 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:44:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtG6i/7SdU9K8+/tW6wI7WSYYn7sK/cBZpg6EehcvGjuJe9vw9lEIekn68jbFHFb5d5iUXBakInOik9WEszyMRCZJS71xp1oR2w4bWv1SHuoqenQChDGIb4CM4diZk7PaOWr+u/UP6WmSHAy7lfME8nCYBICYJA2RUyDm7bwKqEPNBXI/rudn7tzvBDxHtfylh1KkTv6EhEBhbgKE8GbdOdmPCp5NcyZDXDVvTzF8N9G/z8s9Ug9W3rCoDqcJrZM5zFKhkyysPnd136NkWE7BywoBFi46VeHOax6Hea4FsKBrf0dGZt/GsSyCgV4wcc6xISj50gh0QGkc045moRziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cgA7XI2b8qExk0OIxF80xazAUFwJtZ3ZYM9ngvMGXE=;
 b=g+RglSXfCUbl+kDZBwT8fjhb4AwTeGt19+rSfXPCxPJzyalCDDR06ke9xu7zZmGlC6qCJ+0d3E+iXtpWb2RTvllkNodutIbmGwL9eFV1Xp0uTR8rXbXoEm6wDmL/y+mekkuknVC06s48WzbE2yj9j4ypVt2KLNXYkYMnljmhJrz4xKLCbCQmm1t8ZM7sV/hdX0GvFQuRRh7v2WlDYaESE1/gpe0pZXiDKy9yl7vUGGJkkOHfWZ13vPA3uyio1n3U61a1fmtDQKuxUgmKThbF46bgds9Kuk1dRd5yPyOYKe5DKvszEkybZhUqiXwOygKdOYl9BmYVxfOjtoMTjzAEzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by SA0PR11MB4702.namprd11.prod.outlook.com
 (2603:10b6:806:92::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 10:43:55 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 10:43:55 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, "rppt@kernel.org"
	<rppt@kernel.org>, "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
	"mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux@weissschuh.net" <linux@weissschuh.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"pratyush@kernel.org" <pratyush@kernel.org>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>
Subject: RE: [PATCH v1] docs: xforms_lists: Handle DECLARE_KHOSER_PTR() struct
 members
Thread-Topic: [PATCH v1] docs: xforms_lists: Handle DECLARE_KHOSER_PTR()
 struct members
Thread-Index: AQHdXEliyh/CMEoOPk2RI1j6x+yQqrcH2X8A
Date: Wed, 21 Oct 2026 10:43:55 +0000
Message-ID: <CH3PR11MB566895806CD57885588B872A01E5662@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261015020313.946940-1-pasha.tatashin@soleen.com>
In-Reply-To: <20261015020313.946940-1-pasha.tatashin@soleen.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|SA0PR11MB4702:EE_
x-ms-office365-filtering-correlation-id: a18482ad-f2aa-4050-6f77-08df2f603469
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|921020|6133799003|18002099003|10067099003|22082099003|56012099006|261009223027099003|11063799006|38070700021;
x-microsoft-antispam-message-info: 3ko9a1gji2PeisuO9U1t1rzgwua5kFMrfyJY1ZevZF3jsCUG31oeqVNGUHW6go7JrCo8hWmfiBA+eohRTQYNFQ/5WFohZHfTjAX8PadAtvlyNsGGj5tg70dK0fcg1SbIi75u8Glx5YMehj7ZO9Ri3mvqdQM8inoTwuvZ9Iptzk0i6BIsd6sGnngNbTVdbnK4guLCzFiJpt9LS0kD4evrpn8n8WRveOX5kIDkcsC3qYFd9EVpsxUvakXvRAlMrm4P2h3KR+cLAUHF6bUWHvcOOGQGVmy3MNK1SmPsKCRHw+XbL6g0f8R/d1FkwAPhSe+NY6DfgHOAu1MiO0dvr1RPJsuCq9iKYCasloojGjj9fa98MjGWGu5N3E1uFMUWH2/q2EDw6j0H2eaqguh7yl73EbrSM9ODy4yoXauATtYO5Ks0wkzhJ1X0xbZj4nyG+vVPqcnxvmjtW00Ovu+b2TRlPzp4MKAngf1OOy8VXt/FuAKeC8jpwedXH0Ob08sB+6lGYacSDjv3y28NJQmFhp8y1lFQ6grv3CRMB6BKoLbQSIdcPE0xfCkYnHHMa90Zxu57jnXi18mNx2EKqZr0xCEC7SpkGfmJx3RVrgv3tgR+ZyDtvJFkux11LZYG++rZ2qzrgNcY/vcaCusv8MwOI2VbSei+C7YMvGFx5ws5iBdeq9NG9EOQjHwgM/+AEmOclQ1pd6o3mWoZoilmYvIIw0QpXs+PEq4EQYFTxGkDU2wLeI4bhOnZh4cy5YrWu9ZVbEL2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(921020)(6133799003)(18002099003)(10067099003)(22082099003)(56012099006)(261009223027099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xNAA17bc2vmCEHTzscyrBdDdc2y1Qmcb7wSKTbgPqXfW/Gf2i7OT4fEI7pJv?=
 =?us-ascii?Q?AYS2xFgfR11UCXj7Tv0lBwM5yy5KPnPXlXLDhj8rDkNKNioIQIfo+kvtCEcd?=
 =?us-ascii?Q?wIXCMBNcMja7kfYZz6fqVczKHplS45HkrlS6Rw1wChXsT0Srmh51M/ooOjXz?=
 =?us-ascii?Q?HEuzwT2V/iNet/nIz5dZ8K5NG4aCvEVq35wo8EsHZU25gDtjbRP5bFwK9sDK?=
 =?us-ascii?Q?N6A5/sRwe67o0o70qAslVy5VO+QDWQoIRav8WW2kfuhbpmV/SDoWT1AIxTSv?=
 =?us-ascii?Q?qhkGhmq6N6Dx3MaJMbHMAR7cB8Fi60FeKPJ3ykjkaGg9/ouVwcu9qzlw10ev?=
 =?us-ascii?Q?GGah2xkJ/q2bSSO5xUWddJ8XTcT0tSrUztBL4WiPGcfZCKaPBIaTEaCro/Q9?=
 =?us-ascii?Q?RQ89E56IiW16tWqVfFM0UO8dEHsdPJogJ/0ASNIFAoCLuY78vTiuQ2fklwt0?=
 =?us-ascii?Q?fLuOqaBlgqKuCCO26cXy2b/L8tvT6fmD+btBIUGdN4MqW1R4cmQA0FOlBjbQ?=
 =?us-ascii?Q?Z1eNQJY3l1iUbl3p4tqrl+vsY1c8FmlUundMnv3gqcco8TYRN/NTnKbus6z8?=
 =?us-ascii?Q?B9vCxvVNSw6fkEo1XYT4CczkABkOOEPsKp0YmJ/ztanILV2SzNt6n6Mitt2Y?=
 =?us-ascii?Q?2SA+TqkYk6fXrVeGgOkz8SuYFMO58XRF07PxBbgN9aSRfxO6ev4pqowPxNbR?=
 =?us-ascii?Q?absRMeJryEn8Feq0oed0ScTmVxLJQKFkqNCN+8sdHs5jxZagmnc91tcHoAuH?=
 =?us-ascii?Q?oaazCL4ICkmJzX0lcSJ/RT8aSfzBZxHAUKpSUqGQS9/N8JEL5fcxzzEaPCg7?=
 =?us-ascii?Q?MxFwqP4OthQS/8Q/URIQuPCKYyip6gKyHk3BOucAL++j/9rgCNZFSNtG6aRZ?=
 =?us-ascii?Q?JLFuvtIIyxIz+nMiMiKA+UaliCwfmqfYg2bgp67zQAEOhKwewKdRhUNtSF77?=
 =?us-ascii?Q?9ibNndZx3nan6S1Q8tR9AsPFpy5fTt6xuwWdjXBi1xqnEUb0mMSoaqIqfot+?=
 =?us-ascii?Q?f3bOuUnztbCmY16+76temWiKWBw49u5nxvtEJQ++xlT9S+ViirJWFOci+gpa?=
 =?us-ascii?Q?R0AiekC6iv9AA6AEucIyOmAXd7U3NpELyD7kc8z6FnoaLPVPixhwuEzsjHrt?=
 =?us-ascii?Q?AMvgk0ec0WItz0gzFX2QgwwnyNohnHQUwhS4+sd2j+Qiq2qCV6pBKKkqzozr?=
 =?us-ascii?Q?ZvQdWhOGqB5a24GGpiVb3IDu6qyn8egFOtzOWWNdV7YV7vNdxodzZmM/RlLQ?=
 =?us-ascii?Q?MmvSUODKxUMPIFcjci8u92KBQutO6PDFI3WhZfk/add595F5YZwzrDmaRY4U?=
 =?us-ascii?Q?vUN71sTbvXmbU7g0s09/nX/Ne0ycbjclYAci7GWOtpSjfYyzMycPk/p98dHi?=
 =?us-ascii?Q?yaGX5fEWJd/jnw7AFsiN2nomC9/lhQfhYYSvvnykqjdfiS62olFdjK513t73?=
 =?us-ascii?Q?Sc+brQGjUD5wps/etuCT3npmU6e875GlwmJ+x5jRWW08C+nzw+mE2t8FGCL+?=
 =?us-ascii?Q?XG8SLxcjSABklR7Ce/2fpWuJ6OsrSttXLK/W0l/Ro5Dr8grNRDiNYD5qLUgu?=
 =?us-ascii?Q?4e/Hl39tOYS22/ivbqDUlkCro5S1bQXQj7tRJg0Mj2JyjPYoi2+FkrQg5MK6?=
 =?us-ascii?Q?qGPyREQA9r0dA3pjEIk5IOFIJ/VGj6plzr4L3pGgcmbHNB8EqcGwAeR2IwmP?=
 =?us-ascii?Q?YtYNCsD+ohW/372QobpVOAXt6dF9FNLoyu1emQhgg+Q5V1j0aGGKmBBqctfo?=
 =?us-ascii?Q?BNMb602k8FDGFtKN4dVJwGStpwmaP/I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: anuZBYvDb0EF8TPq1cSgYzX02ggbdytOU9lC45/w6px4qF0L/lEOCsA3ZF6eTthm7ZJtQZrgQczZEiuflB5EXfQdlY2p0azL4Hgu6rBwDYa1vpv/tu+XbzwqaQId0F57F09A29U9wLh84dZ2foaxfwfgZLIgcoub4bXbE7ylRfgFJvbo/jkH3VK+atLuq42Ks0oaHK7YvRSkCQ/cJfHyfwpDqGtixXVobOyE1v0tpZLFOJ1e0pyjdvzTiU+avJ8LAFb+ymnEfr9UnlJvoWR4oivb77Or38D4XNrKZdUNuTPzvRLHye4PmuVIcHr1mlhJhAlwfjR6xBnhchiNYd/KxA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18482ad-f2aa-4050-6f77-08df2f603469
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 10:43:55.2190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YkgUyQ/i+2xsGUEoQw9cmmXNPcneypblaKjb+spGFmI1Egwk6Wkc2XSbNWnHXhfkLHXdjPhBcdM92ZrvHkAQaaGR42gypYJJgkjzBit08OY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4702
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_034404_134253_D95DE24E 
X-CRM114-Status: GOOD (  16.60  )
X-Spam-Score: -4.4 (----)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Pasha Tatashin <pasha.tatashin@soleen.com>
> Sent: Thursday, October 15, 2026 4:03 AM
> To: rppt@kernel.org; tudor.ambarus@linaro.org;
> mchehab+huawei@kernel.org; skhan@linuxfoundation.org; linux-
> doc@vger.kernel.org; linux@weissschuh.net; linux-kernel@vger.kernel.org;
> corbet@lwn.net; pasha.tatashin@soleen.com; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; kexec@lists.infradead.org;
> pratyush@kernel.org; rdunlap@infradead.org
> Subject: [PATCH v1] docs: xforms_lists: Handle DECLARE_KHOSER_PTR()
> struct members
>=20
> KHO ABI structures declare their preservation pointers with
> DECLARE_KHOSER_PTR(name, type), which expands to a union of the pointer
> and its physical address. kernel-doc does not know the macro and does
> not see the member: it warns that an unnamed member is not described and
> that the description of the member is excess.
>=20
> Translate DECLARE_KHOSER_PTR(name, type) into "type name", as is done
> for DECLARE_KFIFO_PTR().
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  tools/lib/python/kdoc/xforms_lists.py | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tools/lib/python/kdoc/xforms_lists.py
> b/tools/lib/python/kdoc/xforms_lists.py
> index e3dda2fe8a537..e81d8a7702cbb 100644
> --- a/tools/lib/python/kdoc/xforms_lists.py
> +++ b/tools/lib/python/kdoc/xforms_lists.py
> @@ -45,6 +45,7 @@ class CTransforms:
>          (CMatch("DECLARE_HASHTABLE"), r"unsigned long \1[1 << ((\2) -
> 1)]"),
>          (CMatch("DECLARE_KFIFO"), r"\2 *\1"),
>          (CMatch("DECLARE_KFIFO_PTR"), r"\2 *\1"),
> +        (CMatch("DECLARE_KHOSER_PTR"), r"\2 \1"),
>          (CMatch("(?:__)?DECLARE_FLEX_ARRAY"), r"\1 \2[]"),
>          (CMatch("DEFINE_DMA_UNMAP_ADDR"), r"dma_addr_t \1"),
>          (CMatch("DEFINE_DMA_UNMAP_LEN"), r"__u32 \1"),
>=20
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> prerequisite-patch-id: 557b4f406b7530b8be07d3e3aa6015ad89ceaa6d
> prerequisite-patch-id: c0430a4f0096e4be93a6200aa4e8a1d392238ca5
> prerequisite-patch-id: 524c71eab38a9175f9920f38717c8ed3b157299f
> prerequisite-patch-id: 61cfc274edef2fb23a1b867c9e0d063578387c45
> prerequisite-patch-id: ac022b05628f8e495a224216352aa037a022aae4
> prerequisite-patch-id: 50668baf257da9873190d08f21538ddc453261a8
> --
> 2.56.0.385.gd3acb90ef8-goog

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


