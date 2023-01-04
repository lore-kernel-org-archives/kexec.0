Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C207BC4332F
	for <kexec@archiver.kernel.org>; Wed,  4 Jan 2023 18:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CsVt3D4acTn1nIGr8+0jeCr0/VVfpoejK54fwP2nL8U=; b=fcMjkCmhhcbwHX
	4+JTGVJwUU5OnmJkbS+cznabPAAdFirtTRS9m//PsqBmJgnd1NYPvZgE9M88AsaF6LKqe9dO6apcq
	XtyhMcCHYy8Lo8udpJA2W2u6jDl/Bskfid/E6GTYqgJbXcada/vPlE49yL0HvxXkyvh+nBuY9fOGH
	i37mE5V426AVlQf+rpQ1SiRkkPcMaoR1JXHllauABL/N2fnSL/wcaQzX1x5DHpVWawz4QCobolMEt
	WHfxbrJ1fXAoCoQUlnhya9H1ZRMVn3itSHycuLztEc9YbunMRTfdPjwMywvllxfYQ3dyStOzXQ9J3
	AIKbJTZkM4ym5GQ7aJTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD8qI-00BAqf-SI; Wed, 04 Jan 2023 18:50:26 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD8df-00B1Uq-AB
	for kexec@lists.infradead.org; Wed, 04 Jan 2023 18:37:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672857443; x=1704393443;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ML+G8wE8HvVBjGchvfSyQ+8atDsoyJghtlCJAdYi6HE=;
  b=R5sNtni3RFtsxbMawpisaK0/3z0IpVgAJDAv4k3Pup41ZhZRTb6KA7Tg
   dOTccavs5x6bCToXawS4nmVxvBs98obK2IKSKLkY0+QSjqAf1DYfu//vv
   bQD3ajz78CXCJop7SFeN/aDrfSj+pY+7ivp0cADLN3ANv1CfEvL1QqyzJ
   KxsNQayUFkd5asecmB/vfXFrCGswNfZ3iQFVP2s2K5x4SCcDFq9basER2
   QcrdB7pGmWwbeRzFJuX+p4adVmXw5qxnIzrL75LAoP0wGbeNed8cI8vTs
   la4kQYVjzp5/BaKry5+BjYJM0OMcQ9kTdgCPg+iRQF2lLc9YpkaMd76gU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="322085772"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="322085772"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 10:37:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="687619182"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="687619182"
Received: from cheungbr-mobl.amr.corp.intel.com (HELO [10.209.91.155]) ([10.209.91.155])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 10:37:13 -0800
Message-ID: <e587eebc-5f28-0a63-9200-b67ba20ea347@intel.com>
Date: Wed, 4 Jan 2023 10:37:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/2] kexec: Remove unnecessary arch hook
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: Eric Biederman <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, x86@kernel.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20221215182339.129803-1-helgaas@kernel.org>
 <Y6KiH2Nf/hMiaPmD@MiWiFi-R3L-srv> <Y7TwnyixithmnizI@MiWiFi-R3L-srv>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y7TwnyixithmnizI@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_103727_824472_6F7922DC 
X-CRM114-Status: UNSURE (   9.47  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 1/3/23 19:21, Baoquan He wrote:
>> Since it cleans up the last arch specific version of
>> arch_kexec_kernel_image_load in x86, maybe this patchset can go into x86
>> branch?
> Could you consider picking this patchset into x86 branch? This is a
> clean up on kexec, while the last ARCH using it is x86.

I'll stick it in my queue to take a closer look.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
