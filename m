Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bkLqP-0002dI-GB
 for kexec@lists.infradead.org; Thu, 15 Sep 2016 01:52:06 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8F1lcCX061194
 for <kexec@lists.infradead.org>; Wed, 14 Sep 2016 21:51:44 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25es0pfahv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 14 Sep 2016 21:51:44 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 14 Sep 2016 22:51:42 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 632181DC006E
 for <kexec@lists.infradead.org>; Wed, 14 Sep 2016 21:51:40 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8F1pesn4997122
 for <kexec@lists.infradead.org>; Wed, 14 Sep 2016 22:51:40 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8F1pdAl018349
 for <kexec@lists.infradead.org>; Wed, 14 Sep 2016 22:51:40 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 1/5] kexec_file: Include the purgatory segment in the
 kexec image checksum.
Date: Wed, 14 Sep 2016 22:51:36 -0300
In-Reply-To: <20160915114308.19195f71@canb.auug.org.au>
References: <1473900890-1476-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1473900890-1476-2-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160915114308.19195f71@canb.auug.org.au>
MIME-Version: 1.0
Message-Id: <4542776.bqQjVnlNjh@hactar>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-ima-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

Hello Stephen,

Am Donnerstag, 15 September 2016, 11:43:08 schrieb Stephen Rothwell:
> Hi Thiago,
> 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 2a1f0ce7c59a..dcd1679f3005 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1792,6 +1792,11 @@ config SECCOMP
> > 
> >  source kernel/Kconfig.hz
> > 
> > +# x86 needs to relocate the purgatory after the checksum is calculated,
> > +# therefore the purgatory cannot be part of the kexec image checksum.
> > +config ARCH_MODIFIES_KEXEC_PURGATORY
> > +	bool
> > +
> 
> The above should probably be in arch/Kconfig (with an appropriately
> changed comment) since it is used in generic code.

Thanks for your quick response! I'll make that change tomorrow and send an 
updated version of just this patch.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
