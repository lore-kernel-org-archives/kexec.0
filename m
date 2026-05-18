Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74762CD4F52
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 08:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nJVdOxyPqg5leBOdyWc7JXHMIQDEhMkRyAz0QmpFBDE=; b=N72jhfOB/04PAFM7P75GOoneIX
	mGN2+uL7KDwCuoNgQZ1oQjrMoRGO8eKukj3LJYBJDbO5vrScTq0zL+yEo3d6yWLXgXIHTbIcVHhnx
	Btq8mn2hyDSsicvN6T+BjOcv2VwPRTzJGysm/xpgeUrpvyxzL4HMR5ibXaTsScxAk+dVAATB1X3y3
	4djzHCC4fLF5d0TBMwppS/KrHXGInbj6LiUVw3DzY2oBXMzK1RZTXdZ+CMK75XFFaxxtBFYVtqRpF
	TUXN4W6tsHMaZvgOUZiGyeq7X6REGzYeGp5OSKRcORx/+faxsE0GPu8m/ZAJMFtPWewiSJ7Fcmy0k
	bFal1Ulw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOtPq-0000000Ep5d-1e9O;
	Mon, 18 May 2026 08:33:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOtPp-0000000Ep4j-0lK9
	for kexec@bombadil.infradead.org;
	Mon, 18 May 2026 08:33:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:
	From:Sender:Reply-To:Cc:Content-Description;
	bh=nJVdOxyPqg5leBOdyWc7JXHMIQDEhMkRyAz0QmpFBDE=; b=OTBKmHefCAKZCXLY2sArfqZNk0
	AbHIM/hek6hPRzpdAAZK8r7Qj0gK7Mc5PBMPyNmSgoMdSYWNa1Ynp0h5yhIjk9/k5gyZ40Zaavb5B
	PPAbDPr5c51RL8knSsPhXn6/3ACM31j0fsmphcSmM8Hw69Btp5PNPVm6d9df3/FP43alLCKWkeQ0o
	1Z4neE5E5AidXA2gQppswWfEu4APF9ZnDGi0zonnAtGigyAOE/5E7dRhmjm+OE/SFltHMq8+6cU1K
	zlvxkggpUyboJJFzLjadasxp8tep6rzUbDU3Y6zburWZvDmQXQzckToqfRY3JIfmUEJa2851Rd5Ha
	4qoK9jbQ==;
Received: from mail-japaneastazon11010008.outbound.protection.outlook.com ([52.101.229.8] helo=TY3P286CU002.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOtPk-0000000AOPh-2hlV
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 08:33:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlKgW4OIRVFxXNQ8FujKKJQYMFmw8WFt1266FZDLvMDnvTNvotAbRrm0rcxi3uGFA31CuJoT9mbnV5h3grJwnM2h7zh8opY6O69K2Jw98zSN9sJRchol+PrWMVGLsXE2M9CEh1aLgX21dDjl4CKL33LnG8qO2XCT4YGEuWjG4Y8hUzeyAu6IHc1EFNPsWnJtcGzcjqI93qkWKGv6kostJepF01kJxHQrC5tbzG2NTY6HrqtuRu+wOhEp/ljJDDEE9i3Y6fOIh4mTTwNTpZnbPwBkVkB9PiSlL0Y9ctp0uO0xjamQB4PoCWaGv8jsv9EbQ45pu14ROeYym+EnQmM7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJVdOxyPqg5leBOdyWc7JXHMIQDEhMkRyAz0QmpFBDE=;
 b=hEP/mTJyCD3gnraFBfe9NluOmEBCXIP/DuPhpxYVFKvIsD8uJaRQ0xWHnGaK3PkdcMhwIRc7VyxBzdDFxY+e9DxmmajrGMZLpUG7NIL6zqw8krifpF//zvXUxkKwLIhzP9HJWlerexd/kg/cEgUVeuuv3gLIecguaqSpyA5rzb2/a91VsK6MNpeea3jVVwGLpf8MGPEoIcN2x+cGwwCLzIjiN85kZDQH4RfDsSfsA+MoV4vFL+No8NAo2GdYPzwtUjBMxK2JIfY15Ph/Io/s4VwT/xzG81+n+AX4ovu/ce0LM4Q/ijt+jcmdycrv3vpXTO5FATNsvj7LTn7deN5EOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJVdOxyPqg5leBOdyWc7JXHMIQDEhMkRyAz0QmpFBDE=;
 b=a2XMSprCrMmVq1hNTca2cysiKQmJMYZdeJg5LTGaLICrNp3m0DWCaeoYDNlGbjfgQy2+QRpiVaotaMMGUVnfvppmDgKfpI/jIcs+0f+aVLTCwyoEKLeA22jcDNgI1QRJgsFL6SzOvKzWAes2xr5i7e+OJoZUInHYlj4mLp43ODT8R9CbhJliL40ZxLQxwZxJsDdoPauTAcD1CYXvFpyqOVldJgEVVkME6BKrCTALbkGJbRMecdrxKTfa17qwIN5RNgukBN3VCqR6+H8I/uUKZLMzrDzOPwbUz5nosJVWyozlPlmvt/U3V/uj7rvdrWY5v9b70hgIYYb+AJ49IrGi9w==
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 (2603:1096:405:1d7::13) by TY4PR01MB13763.jpnprd01.prod.outlook.com
 (2603:1096:405:1fc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 08:33:12 +0000
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820]) by TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 08:33:11 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Rui Qi <qirui.001@bytedance.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH v2 0/2] Fix riscv64 virtual-to-physical address
 translation
Thread-Topic: [PATCH v2 0/2] Fix riscv64 virtual-to-physical address
 translation
Thread-Index: AQHc5EH+NfUfRvKayU6fqxkbGUHNZbYTeUGA
Date: Mon, 18 May 2026 08:33:11 +0000
Message-ID: <fe6d8428-0dde-4005-ae06-7f9acddb314c@nec.com>
References: <20260515080745.70110-1-qirui.001@bytedance.com>
In-Reply-To: <20260515080745.70110-1-qirui.001@bytedance.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13462:EE_|TY4PR01MB13763:EE_
x-ms-office365-filtering-correlation-id: 91cd1e76-c138-41e1-29da-08deb4b818ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|11063799003|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: rmzQM783WuhBHLZ/pIHudlJKWDxMHnzTwVQMek73q3Fql/GYhDR+TxpMHvJGMme0mEVBTeB1D5dGAc024dHJTGMFKTmFZsnl1Ij4sTPf8m+51QRNai6/3sqsPDbB3L/L1hmgxhqDOncy4hXix6rxwWZKo1Hj/Nlvqk3f4I2ZBnnYcv/WRp2+xP23wJqVLEsiO98WLXxt2wNw8THWzV4WS8xF3PzblNLS578XmDTvpmm/x8LnNUQwRrq2rJDeZoXHq+Z+TNfilvWsT5avowbtAPk+honjoU1XC0dNd85pbowLKiuvRxxQ4+N1r5x6NltPtD+3g+avaZ/ljMUhBsGd1gXAUvtvXDXeSXq2eSVZ5QZ8mDLj8VgiyaLE6i1Mhk/qDqO26etGDTMnGaWjhbfiJ6bx5zSqEEauHLV5oZMz4NHrif4pUKF+wIOtsQCyrgenTVSm/3I82mUGYb0LYwFXA482t/t39Y8rzFLN+1EIAJChfJqBHWrF1vM18eWdLRwPngWA5Z7ktLrlJ+SqCrjbDVIKXNdDq92L6ndCYQw00JXqnyEuQxLkRxvMykQBFBiyxNA7BFVnEsgLZMDjNY3CfKKzTJ7ELnzbHtKNv9wPuzMZ6ugcOOYNmXJXN0Hqc8y0v6C4+YQaEd+inupcYrcRYzXcYfwDQf5IIWCxhejYumEOC3yqwOAKdexLpd0J/jczJcNqwaGBXBCJzRgVYhN5O4jTGJz/6PL/1UJ/xe9OP9QwY37xeeeior4YbJd+00g4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13462.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjB5MUNjdnUvME5LTysrVHdrTTJySFE4Rko3ZWdWNytvZk5lRWFrdkg2RDAy?=
 =?utf-8?B?UHhBbis0K2oxWllMd0FXRUo1VVZ2QW5MY3JBU3NwTVF6czRwSmdvVWUxb1Az?=
 =?utf-8?B?VExyeGgxZGlMRDhVZWpMWHhidDAxWVdqOURRTzFjd0lGZ2ZDSk1TWFBtTEs3?=
 =?utf-8?B?dHo2OW9tZ2dvNmVqZExWTXNOUko0eGhIRlduS0c0NmMzR2pLVlhZRmlSSlpr?=
 =?utf-8?B?ME5NVUFjajEzMXVTcDJwcklSNmJ6QjZUVEd3OGp2bW1CVzQvVERscDk3ajZn?=
 =?utf-8?B?UmdqYnE4QTljWTNjTTlERVlnd2E5L0x1RXZKeVJjR0lSSjk4RTZmb1VWSU85?=
 =?utf-8?B?U3FGYWRWL2xaeVo2eXFncnRNOGRmOU9nbGplanFobkp5clM5SDhWdHhldEFt?=
 =?utf-8?B?WHFSRXRFRWdTbjZVOUF3MWJ6aDJMYU01MjRoSW9sUHkvWTM2OEgwQXRXT2R3?=
 =?utf-8?B?TUx3WkxqUU5WSEkwNmxETElEMy9FR1oyK3FFeHhwa2o4WFZINzRlODdjQUh2?=
 =?utf-8?B?UThUcG1YVGZGdU1aMXZGMXVaQWRrVW02c2FGWDFMbHp6bXRNa00xbzIyUk96?=
 =?utf-8?B?QjNqWWJvSW1UeTg3Y3lKbnRJbUpjVjVNWG1Nb3JKaXU2V2w2WmJyem4rUHc3?=
 =?utf-8?B?bTBKdmhQNDhjUjQ4aGcrTSs4Q3JkSm1aMUVCY1drNG94V0FTbStSajJIRmRK?=
 =?utf-8?B?ZE45TkQwSFZYMDU1N01ObjJjS0trTUxjVEYxa1EzZkUzeUF0cnlKbW85VHc3?=
 =?utf-8?B?dmlzZk1rUW5HdzR1N1NFZkNvYTk3T29JbmRyVWxxRXN2Ujl4OW5KQWZuYlRO?=
 =?utf-8?B?djlrQ0hYZUpndktEQmlmb3c0bCs1OTF5aGQ4NzVWbWdJRml4WGZaSUdFRGxH?=
 =?utf-8?B?SnhLaG5hSHBMQUxpbVdzZG04Zlp5OFFvMlh4VzVPeWZmdmpyMjllYXhPdS9T?=
 =?utf-8?B?Y0Zxcm5TUTNzRmMwK3FhTWRUR0hWQTdCbHhhc3dlSUh5bHY4TnZjK2N1TnZu?=
 =?utf-8?B?UVZFaFpIcHFWZDBnSy9nRWg1M0s5djVZS1diNjRoZGQxdTNROU1aUk1lZEZQ?=
 =?utf-8?B?eFJER2RJVm9ZbHFIQ21waitXc0J6bWtDUlF2WHErcnJVa0NieUNMS28yUW5t?=
 =?utf-8?B?anZ2SEp1aDR3Q3RkWnFGRlBSdTRsUTBzd1BsOFpBQlE1d2dVUzlDV013U0NS?=
 =?utf-8?B?Qk1mTTRQSVpVMm1RS1FOR0w1YTQzOS95V3NDTk1YWWdtSUZyTGgxNHhuVXdn?=
 =?utf-8?B?UVpvSkZVYndBeDNJYmJRNlBtNHhaYWF1RlRjdCttMERJQTVFeTVvZ1duUGN5?=
 =?utf-8?B?UWh0NjRJcnhrU21aeXBpZ3ordEpGOWY3RFlTZnhoRzVPMzlONmFMbnE4SFRm?=
 =?utf-8?B?bnEwZHFZQi9KNktXMlB0b2pWUkpQczI1MDdSY1Q4dlRXTU5wVjd1ZEZ4b3Y0?=
 =?utf-8?B?SksxUVV1WFU2b3YzTmRTVmJYZ0JRZHNHaVZDeXFuRnVXcWF5VW5pbTY5V1Fj?=
 =?utf-8?B?T3dNb1FtVVRCc1MzUDYwZ3RHaVY4QVhHSWV6cWk2aVI5UFVRK281SVpSNWYy?=
 =?utf-8?B?allEbFpxRW95dFhtQXZGZGFUeHpnWDRUVkpiaXJOMmFDTEFXNmlPN3dJMlg3?=
 =?utf-8?B?UkRWNEJuanROWERzSDhsU0oxR1VkdTRrc0h0NW85VmVsMkhNY2UxQjh6S3cw?=
 =?utf-8?B?OXVZbXpRTVh0d1E2UmpqR3ZwN210RmNsRHk1TjRYVXRiYlMrYlNmSW9kYTJt?=
 =?utf-8?B?SGFwRSswMkpjZC9HUHQvUTdlMW1JeVJxRVdmUTRnWld3L0x0NC8wYzJ5NGln?=
 =?utf-8?B?VzcrQTlPVHFpRXV0V2YzKzltdi81UnlvOENEVHNXVWh2aHFXc2lDdWRMd1E2?=
 =?utf-8?B?QjFwVHU5RkJHbFByUXVlQXJMWi9KWC9FdVZ0WmllQy8vQS8xbW9GTHNpVzA5?=
 =?utf-8?B?dVBGYlgydWp2ZDBiVW9QU2hoTU0xazF5ZUx3aW83dDNqejlkNm5LUGN6YVUx?=
 =?utf-8?B?UThoY3VQaXVubVJTRVA1b3JyWWMwdkdSQVpwTlpvcE5sV0Q1K0ZGTjE5VTV6?=
 =?utf-8?B?Q1NTb3dxNVpDSlBkdkFKUExqRVkxUlhTMWdNUEF5NytzdWpGTE5abzc1eW9Z?=
 =?utf-8?B?MHByWVIvbUJ0RktxaFpGVjFkWEtGTndBdkp1dkMzOGZta25ybTh5WnhwWjFW?=
 =?utf-8?B?a1FlTEVtM3dwTGoxZmFWbExyRnF6OHE3Sk5jalU1Tk5MZjJyWmZWQmEvbVBH?=
 =?utf-8?B?UTlpeDR6VlFPVWt6bmFIcXlZSWpGa0hIbVNPSmlvQ1dYNmYvMURjWGw1RnVo?=
 =?utf-8?B?VkFneTcwbEg0eVFZNCtoNThXaFhzdjh0UXdiT0wyUFVGZDYvWUQxUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6228AE77477A2C438F7439F017793974@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13462.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cd1e76-c138-41e1-29da-08deb4b818ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 08:33:11.7981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +0ep1Ql/z7kCcHDqm3eoOlWH+GLQD8tz/660RwtbzJ4s9wrSk7NBAh2L7c/CS3JB835pLQLoK2R4gzBfqsMtgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13763
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_093329_599543_888F31A2 
X-CRM114-Status: GOOD (  12.40  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gMjAyNi8wNS8xNSAxNzowNywgUnVpIFFpIHdyb3RlOg0KPiBUaGlzIHBhdGNoc2V0IGZpeGVz
IHR3byBidWdzIGluIHRoZSByaXNjdjY0IGFyY2hpdGVjdHVyZSBzdXBwb3J0IG9mDQo+IG1ha2Vk
dW1wZmlsZSByZWxhdGVkIHRvIHZpcnR1YWwtdG8tcGh5c2ljYWwgYWRkcmVzcyB0cmFuc2xhdGlv
bi4NCj4gDQo+IFBhdGNoIDEgZml4ZXMgdmFkZHJfdG9fcGFkZHJfcmlzY3Y2NCgpIHRvIGV4Y2x1
ZGUgdm1hbGxvYyBhbmQgdm1lbW1hcA0KPiByZWdpb25zIGZyb20gdGhlIFZUT1AoKSBmYXN0IHBh
dGguIFRoZXNlIHJlZ2lvbnMgYXJlIG5vdCBsaW5lYXJseSBtYXBwZWQNCj4gYW5kIG11c3QgZ28g
dGhyb3VnaCBwYWdlIHRhYmxlIHdhbGsuDQo+IA0KPiBQYXRjaCAyIGZpeGVzIHZ0b3BfcmlzY3Y2
NCgpIHRvIGNvcnJlY3RseSBoYW5kbGUgaHVnZSBwYWdlcyB3aGVuDQo+IF9QQUdFX0xFQUYgaXMg
c2V0IGF0IFBHRC9QNEQvUFVEL1BNRCBsZXZlbC4gVGhlIG9yaWdpbmFsIGNvZGUgaW5jb3JyZWN0
bHkNCj4gZmVsbCB0aHJvdWdoIHRvIHRoZSBuZXh0IGxldmVsLCBjYXVzaW5nIHdyb25nIHBoeXNp
Y2FsIGFkZHJlc3MgY29tcHV0YXRpb24uDQo+IA0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBQ
YXRjaCAyOiBDaGFuZ2VkIGBnb3RvIGludmFsaWQ7YCB0byBgcmV0dXJuIHBhZGRyO2Agd2hlbiBo
dWdlIHBhZ2UNCj4gICAgKF9QQUdFX0xFQUYpIGhpdHMsIGFzIHRoZSBjYWxjdWxhdGVkIHBoeXNp
Y2FsIGFkZHJlc3MgaXMgdmFsaWQuDQo+IC0gUGF0Y2ggMjogUmVtb3ZlZCB0aGUgdW51c2VkIGBv
dXQ6YCBsYWJlbCB0byBmaXggYSBjb21waWxlciB3YXJuaW5nLg0KDQpUaGFuayB5b3UgZm9yIHRo
ZSB1cGRhdGUsIGFwcGxpZWQuDQoNClRoYW5rcywNCkthenUNCg0KPiANCj4gUnVpIFFpICgyKToN
Cj4gICAgcmlzY3Y2NDogRml4IHZhZGRyX3RvX3BhZGRyIGZvciB2bWFsbG9jIGFuZCB2bWVtbWFw
IHJlZ2lvbnMNCj4gICAgcmlzY3Y2NDogRml4IGh1Z2UgcGFnZSB0cmFuc2xhdGlvbiBpbiB2dG9w
X3Jpc2N2NjQoKQ0KPiANCj4gICBhcmNoL3Jpc2N2NjQuYyB8IDMxICsrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTAg
ZGVsZXRpb25zKC0pDQo+IA==

