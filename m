Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B7EC0032E
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 12:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3t5LML2og7jJVQ8l1fDKEkbvcTD1FnLMtVRBnwCWHKw=; b=TUpWjoAT/S4uYI
	dUcT2/euTtV09tny72A4+F0Tu4cpnhKoJOFhpdrADgijpmG345b6Crog9YF2r4xvelvGF6ApawlVI
	9pyie/g+yfQAB14XkAoKolra2IuIF5eYPQRUwcrR5bqT/RHYpDmZqs+0+cwoHhYcIvfLReYAjH1C5
	D5R0SlGQEpkYa7pWukvKwFzirO5aksOKQo+GMTN76Sze20FH5nAE4ykTFSnVfnE5IKSDUSm5GZmHf
	Xb7khgx9TjP1nU0NWKWcZAn7aHEgM/6QF79ba5gT8n89lNQLCYxuJGcsQrU5v6evT4r6lE1SNbvc2
	pmYzurowpJUkDUgSPTeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtopn-002GGa-0Q;
	Fri, 20 Oct 2023 12:42:35 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtopk-002GFw-19
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 12:42:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697805752; x=1729341752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZS32j1eQY1Yi6SVLYpQrchRlTJGbASGZQz5j7O46Mxg=;
  b=mjaxXvB2L2UYgKEy3IbhAbuKgKp3mHV0KoJqK3x1V3L5KfWjbu3LtRCS
   j5Ybajqwdn8wYdhjL0O72OZrEEgKc9i61c97ZzDxdWTZnT/Rt0jO/7+Mz
   aX+wYbKXyGo+c5Dil17AxKkS+84vt72HBXW5FKFG5NyZ5WcGS/8mvoVBR
   DPXHAMVK9NpRrp80WQVQ6W+4UftYSpRJqAWK1iU63RGSoZDIteg/itsxw
   KlBWmj/yrU2B2piz6jGnvX0u0RDvvTQ1cxbhfAvAEDuaCvXV1VYZ++mtV
   Ny8d+Qwth3U+jvVQhE9ywYAQgYAoiBv7HsTYuGkP7Q941D8ul1T+yV0t0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="452967102"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="452967102"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 05:42:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="931004423"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="931004423"
Received: from dgutows1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.237])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 05:42:23 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id D971C10A1C7; Fri, 20 Oct 2023 15:42:20 +0300 (+03)
Date: Fri, 20 Oct 2023 15:42:20 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 03/13] cpu/hotplug, x86/acpi: Disable CPU hotplug for
 ACPI MADT wakeup
Message-ID: <20231020124220.voezn7q72unnt2q6@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-4-kirill.shutemov@linux.intel.com>
 <9f9fef1eb387e6098ca762d10e9c2002296c89f6.camel@intel.com>
 <edcd14bce71326e168a4dc11e5f1771e6f623aa8.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <edcd14bce71326e168a4dc11e5f1771e6f623aa8.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_054232_510849_5770F586 
X-CRM114-Status: GOOD (  30.34  )
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

On Fri, Oct 20, 2023 at 11:58:58AM +0000, Huang, Kai wrote:
> On Tue, 2023-10-10 at 10:24 +0000, Huang, Kai wrote:
> > > =A0/* Physical address of the Multiprocessor Wakeup Structure mailbox=
 */
> > > @@ -74,6 +75,9 @@ int __init acpi_parse_mp_wake(union acpi_subtable_h=
eaders *header,
> > > =A0
> > > =

> > > =A0	acpi_mp_wake_mailbox_paddr =3D mp_wake->base_address;
> > > =A0
> > > =

> > > +	/* Disable CPU onlining/offlining */
> > > +	cpu_hotplug_not_supported();
> > > +
> > =

> > Both onlining/offlining are prevented, or just offlining?
> > =

> > The previous patch says:
> > =

> > 	It does not prevent the initial bring up of the CPU, but it stops=A0
> > 	subsequent offlining.
> > =

> > And ...
> > =

> > [...]
> > =

> > =

> > > --- a/kernel/cpu.c
> > > +++ b/kernel/cpu.c
> > > @@ -1522,7 +1522,7 @@ static int cpu_down_maps_locked(unsigned int cp=
u, enum cpuhp_state target)
> > > =A0	 * If the platform does not support hotplug, report it explicitly=
 to
> > > =A0	 * differentiate it from a transient offlining failure.
> > > =A0	 */
> > > -	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED) || !cpu_hotplug_suppo=
rted)
> > > +	if (!cpu_hotplug_supported)
> > > =A0		return -EOPNOTSUPP;
> > > =A0	if (cpu_hotplug_disabled)
> > > =A0		return -EBUSY;
> > =

> > ... here cpu_down_maps_locked() only prevents offlining if I am reading
> > correctly.
> > =

> > Also, can we rename cpu_hotplug_supported to cpu_offline_supported to m=
atch the
> > behaviour better?
> > =

> > Anyway, isn't it a little bit odd to have:
> > =

> > 	if (!cpu_hotplug_supported)
> > =A0		return -EOPNOTSUPP;
> > =A0	if (cpu_hotplug_disabled)
> > =A0		return -EBUSY;
> > =

> > ?
> =

> I probably have missed something important, but I don't quite understand =
what's
> the reason to have the CC_ATTR_HOTPLUG_DISABLED at the beginning, and now
> replace it with cpu_hotplug_not_supported()?

CC_ATTR_HOTPLUG_DISABLED was a mistake. And now obvious when we only need
to disable offlining dynamically, based on supported MADT MP WP version.

> From the changelog:
> =

> 	Currently hotplug prevented based on the confidential computing
> 	attribute which is set for Intel TDX. But TDX is not the only possible
> 	user of the wake up method.
> =

> CC_ATTR_HOTPLUG_DISABLED is only used by TDX guest, but MADT can be used =
by non-
> TDX guest too.
> =

> Anyway, if the purpose is just to prevent CPU from going offline, can thi=
s be
> done by registering a cpuhp callback?
> =

> 	static int madt_wakeup_offline_cpu(unsigned int cpu)
> 	{
> 		return -EOPNOTSUPP;
> 	}
> =

> 	...
> =

> 	err =3D cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "madt-wakeup",
> 			NULL, madt_wakeup_offline_cpu);
> 	if (err) {
> 		pr_err("Register CPU hotplug callback failed.\n");
> 		/* BUG() ??? */
> 	}
> =

> This doesn't pollute the common CPU hotplug code, thus to me looks more c=
lear?

Thomas seems fine with cpu_hotplug_disable_offlining().

-- =

  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
