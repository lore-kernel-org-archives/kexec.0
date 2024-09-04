Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3DACD4F23
	for <kexec@archiver.kernel.org>; Wed,  4 Sep 2024 19:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iUAuq5kxho9uj6o2hFSogZC3xzKZChLpbwWyjMAxM74=; b=AcrqlfR+vuqv7B
	fi0yMQgmpBse4NSiWIMHJwfZewMopcu7rW1hif7Qn2jZCDVJWFF2aSaN5eC9Fb3gN7BHVCCtQ7DTm
	LNc4C0RNUCHoyH+8inue9uiJEMX/2RIHFHkrk1ke9kBJ1+zddMHm/6arijpHMYF3510MStY2+aS+A
	rMd6IXipab+yjjAOaIPXWjfgjL1e4QvOGeewHZ2jZKfcmNtZdbx9CouL+w/IG1xL7TCIeFDsSJ4UN
	g5MrWSo4e3N3nPnTbuj6wnKjJ9wIxlTSbICRhbq09HzwYMd6ntY+lgN1B6ZwHU/kCFEtjqMdskTcS
	/XSlgb/x61eqjpCffX8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slw5N-00000005t9Z-3mNO;
	Wed, 04 Sep 2024 19:54:37 +0000
Received: from mail-mw2nam04on20608.outbound.protection.outlook.com ([2a01:111:f403:240a::608] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slw5J-00000005t7X-19fI
	for kexec@lists.infradead.org;
	Wed, 04 Sep 2024 19:54:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flkDS8B3goj3dXPAjgasdYyqCj0lnzr6vgJgAoCHVX1VYuDHMhBp87wolOAFat+VKCQQ2vkb6eezWdRJ4ltqat2s9GeDydOaLrad7pSwltF8sAeYuM0sOIy0iC7CmtR1w6ZE7PsMxf9C4JIsdVRBoLQxsfENEAfUPIzakxS/8XFP7hH9klAwNiIuc9FCUm/Y2QJ5Mu2YChIdDYUpL6+n93PTWbS5QLYguhtaqQMIq//hQj6krpeF9YQHJ6uXTGGX4N++f53MwzTnpWfEMS/2SXGnyYlomfJj/xf/HIbfGDpqao4+NemFIU+h4EmehQfCmFf+Ql1OX1gRZ8x2DggPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlmM40QNbT3cxXF+3cYIczlcwlAUdqPeGyetevigcJ8=;
 b=GuT9v1G2KfCHb1CARc4FhOmhupB940cKeL3WGrw7lg8aC+StucP27RbRbMiefPX2iaRnw/nM9tEQcFSYzA82FjiedbwtwGBzXb0KJtMsnaDEKRivIVszR7PID/B0VP30FYch3ja45OD3HcDc5MXU9lWK4pDu9ukH2BR3UT+dxo/uwA1qixKoeKzEfqLU3/OC1P5fdlp3wVEmEnf0enR6jNN04U1X+YgE7tKYOlMO9bL2i6BmgjQkMWP4dAAvXazNLGr8Gcz+mqPat2NutCi9S2ZcQfU+f4ufSk/QBqoTx99ngUgP1dm//NCsHHogTw1FcneIEEAPVOucfpJOunrfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlmM40QNbT3cxXF+3cYIczlcwlAUdqPeGyetevigcJ8=;
 b=dLG8WdiyFR+1eJeVBEmLt2B3CdFHRVV5XfGGeRZLazmvokzn8BGnioReOdGoZBZxOE0s9lLZ9/Bbx3QoxvljpFXjOxyxphPUVLjX3BhoMGLVTU/CbfJYAnBtlyeiQ3+DQbaHs7Df+ST2fJK4r/6vZOCKlUGPNAbEItmpBv46wks=
Received: from CH0PR03CA0097.namprd03.prod.outlook.com (2603:10b6:610:cd::12)
 by LV3PR12MB9094.namprd12.prod.outlook.com (2603:10b6:408:19e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 19:54:24 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::9) by CH0PR03CA0097.outlook.office365.com
 (2603:10b6:610:cd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 19:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 19:54:24 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 14:54:23 -0500
Date: Wed, 4 Sep 2024 14:54:08 -0500
From: Michael Roth <michael.roth@amd.com>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>, <hpa@zytor.com>,
	<peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <thomas.lendacky@amd.com>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>
Subject: Re: [PATCH v2] x86/sev: Fix host kdump support for SNP
Message-ID: <20240904195408.wfaukcphpw5iwjcg@amd.com>
References: <20240903191033.28365-1-Ashish.Kalra@amd.com>
 <ZtdpDwT8S_llR9Zn@google.com>
 <fbde9567-d235-459b-a80b-b2dbaf9d1acb@amd.com>
 <25ca73c9-e4ba-4a95-82c8-0d6cf8d0ff78@redhat.com>
 <14b0bc83-f645-408f-b8af-13f49fe6155d@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <14b0bc83-f645-408f-b8af-13f49fe6155d@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|LV3PR12MB9094:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8c7df3-fa27-4c3a-0aed-08dccd1b608c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?nMBzkm46r0gYcwFLXv+q3MDOVa3lOZLocJagB+DwUwlLs4UIVCT9a+slZq?=
 =?iso-8859-1?Q?QMhgM57GDLclzRXjN27sCC7vFbdH13roD0g5sj+2/7lgAStT4bqXdOASnZ?=
 =?iso-8859-1?Q?qP8CtrB0bPK/MuUaIbQL4oeiLukW1UxN0tpd60OA21x8CZcO0reIFXZzqo?=
 =?iso-8859-1?Q?hZ6MOHAkSfhQFWeuEch9voiercdlfnYiyr9Age6UvfhmbhZaea8Rb1ZOe5?=
 =?iso-8859-1?Q?sNyiUBfXqv8G5YtQnEVHo7gwcTSswVA2ULh4llEtTYHP0T4LTB0W9xoxke?=
 =?iso-8859-1?Q?D2V82WSvHNFMJEQjmvw1opefhwrftcWyTDYuPyanGLHxg5Z6XAu06IubYO?=
 =?iso-8859-1?Q?IwcIDVNxbfAoxUq5RoYsgFfoP+/ci+i4ggdzKnFyhAPnclZH0gv5S34mlL?=
 =?iso-8859-1?Q?Gq+gXUGHGRkiQpoo4UY5uOqBT6966mvB+itk+2BudC26Cgd70Nt+0h/3Jk?=
 =?iso-8859-1?Q?WUwnRZejc5V44NQRKoiU6Z/6eb9TUUmUxOijHlFjatBGTNBeSKD2wzbadb?=
 =?iso-8859-1?Q?XFzNxLA/VF+E8if/tKX+XzudnBsWJ5tu4YFfUi4Ld75Ok3wz+tEDl59LHb?=
 =?iso-8859-1?Q?w0CSPIUPdtpcTAiTkVJ3Y0XMb9RDyhJPhz/RVnacJNz8wlrN02sKouDrFI?=
 =?iso-8859-1?Q?Ioz6niTCO+O6ODXtCF/LcpK2LAH0TtRpYIHq4l7ZOpdl0fI5u8RNBVS3Cw?=
 =?iso-8859-1?Q?ATGNypZa8rsRyHwHmGhqNOx5S15j8v0kY1qB+eurk8WSlkxiSdAlQDFznJ?=
 =?iso-8859-1?Q?5EYIWLrTCyptaR++qCdB9EHjiM+hDY+Lkhh3BqKi5XKFpnSBD4B2VUGEdm?=
 =?iso-8859-1?Q?1OJXvTyZ1zZWQQaeesafyGbCOh7KVxyzZS3TsiH5FEMn2NAhC3FI21Ktkv?=
 =?iso-8859-1?Q?jPmiyqHQ1mfe28EZnADjrpaoWzbA0LQHuVz1Cg3rCuohTdOTqj+lAdksOU?=
 =?iso-8859-1?Q?u4rAtV23EQs81Oz5D8e4L4f41Gp2ydmCTLmbsCf1JAV6Q6sL+j64YBWlh8?=
 =?iso-8859-1?Q?9dWiyM2d3Xm8+Asim8tHbFyhaehwZGkXuSZAcC2cb4A/rriK6WTgyIBpsx?=
 =?iso-8859-1?Q?uQyLlsZtXc6n/h25/T840ZXVhOfIwHt/8D04VJSjn06a8/rm+93sfOHZG+?=
 =?iso-8859-1?Q?5dz94H+h7jlIfbrjY1VBJeXaMKQQhah0sLlAcqw3x1+2nV+cq1BXXttZq1?=
 =?iso-8859-1?Q?68kbnDCyF2lCbp0VLKm+NxqfJNVf2b0KxxHgBZRWS+R9W86TOr3YhdYzUg?=
 =?iso-8859-1?Q?/mIMeT0q6lGMldAyIPKAO5VbUfCdV3MpSbmyLhP9ouujfFCC4iZf2SPMuD?=
 =?iso-8859-1?Q?7fc4y491d3evo1PKEruLNRAoVc+Ccn7045DkxbQ8xfRLDs/zp23fpPa6Sb?=
 =?iso-8859-1?Q?hKeosT08VF4sNOtXLv+8uRacEA4hS1zjoUEIGbT2CsmCDnXFGN2Zl0NR1n?=
 =?iso-8859-1?Q?A6yOPnx1ynPoOxXZZOcO+0XH75P5PjADlf4VdiMZc1y1RAUVlpt4F+HZyx?=
 =?iso-8859-1?Q?tNVjaolYe+7frK2CF1HK44?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 19:54:24.6588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8c7df3-fa27-4c3a-0aed-08dccd1b608c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9094
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_125433_352558_6CBF9D96 
X-CRM114-Status: GOOD (  46.37  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Sep 04, 2024 at 12:37:17PM -0500, Kalra, Ashish wrote:
> Hello Paolo,
> =

> On 9/4/2024 5:29 AM, Paolo Bonzini wrote:
> > On 9/4/24 00:58, Kalra, Ashish wrote:
> >> The issue here is that panic path will ensure that all (other) CPUs
> >> have been shutdown via NMI by checking that they have executed the
> >> NMI shutdown callback.
> >>
> >> But the above synchronization is specifically required for SNP case,
> >> as we don't want to execute the SNP_DECOMMISSION command (to destroy
> >> SNP guest context) while one or more CPUs are still in the NMI VMEXIT
> >> path and still in the process of saving the vCPU state (and still
> >> modifying SNP guest context?) during this VMEXIT path. Therefore, we
> >> ensure that all the CPUs have saved the vCPU state and entered NMI
> >> context before issuing SNP_DECOMMISSION. The point is that this is a
> >> specific SNP requirement (and that's why this specific handling in
> >> sev_emergency_disable()) and i don't know how we will be able to
> >> enforce it in the generic panic path ?
> >
> > I think a simple way to do this is to _first_ kick out other
> > CPUs through NMI, and then the one that is executing
> > emergency_reboot_disable_virtualization().=A0 This also makes
> > emergency_reboot_disable_virtualization() and
> > native_machine_crash_shutdown() more similar, in that
> > the latter already stops other CPUs before disabling
> > virtualization on the one that orchestrates the shutdown.
> >
> > Something like (incomplete, it has to also add the bool argument
> > to cpu_emergency_virt_callback and the actual callbacks):
> >
> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > index 340af8155658..3df25fbe969d 100644
> > --- a/arch/x86/kernel/crash.c
> > +++ b/arch/x86/kernel/crash.c
> > @@ -111,7 +111,7 @@ void native_machine_crash_shutdown(struct pt_regs *=
regs)
> > =A0
> > =A0=A0=A0=A0 crash_smp_send_stop();
> > =A0
> > -=A0=A0=A0 cpu_emergency_disable_virtualization();
> > +=A0=A0=A0 cpu_emergency_disable_virtualization(true);
> > =A0
> > =A0=A0=A0=A0 /*
> > =A0=A0=A0=A0=A0 * Disable Intel PT to stop its logging
> > diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> > index 0e0a4cf6b5eb..7a86ec786987 100644
> > --- a/arch/x86/kernel/reboot.c
> > +++ b/arch/x86/kernel/reboot.c
> > @@ -558,7 +558,7 @@ EXPORT_SYMBOL_GPL(cpu_emergency_unregister_virt_cal=
lback);
> > =A0 * reboot.=A0 VMX blocks INIT if the CPU is post-VMXON, and SVM bloc=
ks INIT if
> > =A0 * GIF=3D0, i.e. if the crash occurred between CLGI and STGI.
> > =A0 */
> > -void cpu_emergency_disable_virtualization(void)
> > +void cpu_emergency_disable_virtualization(bool last)
> > =A0{
> > =A0=A0=A0=A0 cpu_emergency_virt_cb *callback;
> > =A0
> > @@ -572,7 +572,7 @@ void cpu_emergency_disable_virtualization(void)
> > =A0=A0=A0=A0 rcu_read_lock();
> > =A0=A0=A0=A0 callback =3D rcu_dereference(cpu_emergency_virt_callback);
> > =A0=A0=A0=A0 if (callback)
> > -=A0=A0=A0=A0=A0=A0=A0 callback();
> > +=A0=A0=A0=A0=A0=A0=A0 callback(last);
> > =A0=A0=A0=A0 rcu_read_unlock();
> > =A0}
> > =A0
> > @@ -591,11 +591,11 @@ static void emergency_reboot_disable_virtualizati=
on(void)
> > =A0=A0=A0=A0=A0 * other CPUs may have virtualization enabled.
> > =A0=A0=A0=A0=A0 */
> > =A0=A0=A0=A0 if (rcu_access_pointer(cpu_emergency_virt_callback)) {
> > -=A0=A0=A0=A0=A0=A0=A0 /* Safely force _this_ CPU out of VMX/SVM operat=
ion. */
> > -=A0=A0=A0=A0=A0=A0=A0 cpu_emergency_disable_virtualization();
> > -
> > =A0=A0=A0=A0=A0=A0=A0=A0 /* Disable VMX/SVM and halt on other CPUs. */
> > =A0=A0=A0=A0=A0=A0=A0=A0 nmi_shootdown_cpus_on_restart();
> > +
> > +=A0=A0=A0=A0=A0=A0=A0 /* Safely force _this_ CPU out of VMX/SVM operat=
ion. */
> > +=A0=A0=A0=A0=A0=A0=A0 cpu_emergency_disable_virtualization(true);
> > =A0=A0=A0=A0 }
> > =A0}
> > =A0#else
> > @@ -877,7 +877,7 @@ static int crash_nmi_callback(unsigned int val, str=
uct pt_regs *regs)
> > =A0=A0=A0=A0=A0 * Prepare the CPU for reboot _after_ invoking the callb=
ack so that the
> > =A0=A0=A0=A0=A0 * callback can safely use virtualization instructions, =
e.g. VMCLEAR.
> > =A0=A0=A0=A0=A0 */
> > -=A0=A0=A0 cpu_emergency_disable_virtualization();
> > +=A0=A0=A0 cpu_emergency_disable_virtualization(false);
> > =A0
> > =A0=A0=A0=A0 atomic_dec(&waiting_for_crash_ipi);
> > =A0
> > diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
> > index 18266cc3d98c..9a863348d1a7 100644
> > --- a/arch/x86/kernel/smp.c
> > +++ b/arch/x86/kernel/smp.c
> > @@ -124,7 +124,7 @@ static int smp_stop_nmi_callback(unsigned int val, =
struct pt_regs *regs)
> > =A0=A0=A0=A0 if (raw_smp_processor_id() =3D=3D atomic_read(&stopping_cp=
u))
> > =A0=A0=A0=A0=A0=A0=A0=A0 return NMI_HANDLED;
> > =A0
> > -=A0=A0=A0 cpu_emergency_disable_virtualization();
> > +=A0=A0=A0 cpu_emergency_disable_virtualization(false);
> > =A0=A0=A0=A0 stop_this_cpu(NULL);
> > =A0
> > =A0=A0=A0=A0 return NMI_HANDLED;
> > @@ -136,7 +136,7 @@ static int smp_stop_nmi_callback(unsigned int val, =
struct pt_regs *regs)
> > =A0DEFINE_IDTENTRY_SYSVEC(sysvec_reboot)
> > =A0{
> > =A0=A0=A0=A0 apic_eoi();
> > -=A0=A0=A0 cpu_emergency_disable_virtualization();
> > +=A0=A0=A0 cpu_emergency_disable_virtualization(false);
> > =A0=A0=A0=A0 stop_this_cpu(NULL);
> > =A0}
> > =A0
> >
> > And then a second patch adds sev_emergency_disable() and only
> > executes it if last =3D=3D true.
> >
> This implementation will not work as we need to do wbinvd on all other CP=
Us after SNP_DECOMMISSION has been issued.
> =

> When the last CPU executes sev_emergency_disable() and issues SNP_DECOMMI=
SSION, by that time all other CPUs have entered the NMI halt loop and then =
they won't be able to do a wbinvd and hence SNP_SHUTDOWN will eventually fa=
il.
> =

> One way this can work is if all other CPUs can still execute sev_emergenc=
y_disable() and in case of last =3D=3D false, do a spin busy till the last =
cpu kicks them out of the spin loop and then they do a wbinvd after exiting=
 the spin busy, but then cpu_emergency_disable_virtualization() is/has to b=
e called before atomic_dec(&waiting_for_crash_ipi) in crash_nmi_callback(),=
 so this spin busy in other CPUs will force the last CPU to wait forever (o=
r till it times out waiting for all other CPUs to execute the NMI callback)=
 which makes all of this looks quite fragile.

Hi Ashish,

Your patch (and Paolo's suggested rework) came up in the PUCK call this
morning and I mentioned this point. I was asked to raise some of the
points here so we can continue the discussion on-list:

Have we confirmed that WBINVD actually has to happen after the
SNP_DECOMISSION call? Or do we just need to ensure that the WBINVD was
issued after the last VMEXIT, and that the guest will never VMENTER
again after the WBINVD?

Because if WBINVD can be done prior to SNP_DECOMISSION, then Paolo was
suggesting we could just have:

  kvm_cpu_svm_disable() {
    ...
    WBINVD
  }

  cpu_emergency_disable_virtualization() {
    kvm_cpu_svm_disable()
  }

  smp_stop_nmi_callback() {
    if (raw_smp_processor_id() =3D=3D atomic_read(&stopping_cpu)) {
      return NMI_HANDLED;
    }
    cpu_emergency_disable_virtualization()
    return NMI_HANDLED
  }


The panic'ing CPU can then:

  1) WBINVD itself (e.g. via cpu_emergency_disable_virtualization())
  2) issue SNP_DECOMMISSION for all ASIDs

That would avoid much of the additional synchronization handling since it
fits more cleanly into existing panic flow. But it's contingent on
whether WBINVD can happen before SNP_DECOMMISION or not so need to
confirm that.

Sean and Paolo also raised some other points (feel free to add if I
missed anything):

  - Since there's a lot of high-level design aspects that need to be
    accounted for, it would be good to have the patch have some sort of
    pseudocode/graph/etc so it's easier to reason about different
    approaches. It would also be good to include this in the commit
    message (generally it's encouraged to describe "why" rather than "how",
    but this is an exceptional case where both are useful to reader).

  - Sean inquired about making the target kdump kernel more agnostic to
    whether or not SNP_SHUTDOWN was done properly, since that might
    allow for capturing state even for edge cases where we can't go
    through the normal cleanup path. I mentioned we'd tried this to some
    degree but hit issues with the IOMMU, and when working around that
    there was another issue but I don't quite recall the specifics.
    Can you post a quick recap of what the issues are with that approach
    so we can determine whether or not this is still an option?

-Mike

> =

> Thanks, Ashish
> =


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
