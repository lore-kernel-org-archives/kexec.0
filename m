Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CAEC77B75
	for <kexec@archiver.kernel.org>; Fri,  5 May 2023 19:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eltYtws9pvqv+VtpLyjAdSBsB8EFs9krHecVkSseuC0=; b=sEvnm4cdrtYWOd
	kRziTSbK0MmOfqmqyCgIN1V0JF+vZnUcYvaSWEqY65gQKHXiU6bh6L2+CLxGwE6s96uPpwdbHusSs
	wUfjVL6mvbNguOVE8ubZ2E530BmAlJP2yXQzBJ+ywMXbaLrRgwox8l/RM3fiXPZQLmqFfC9o+Zn+A
	2pGeXS8amQzikpdR3FIb6CfksRCQNyDDS1HtMqd6pPCsGo4ffh69voAhmStiux2Agud57rt2Ejol7
	MvNcvOboW+Th/bYQY/vF/4LJZNPctwco6uyoSHXLJtupmlKeI/ccI28zwcWmDGVauxBb9rJdCGmbm
	2OEzrrgLh9LrI47Jfm7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pv1OZ-00Bf2e-2M;
	Fri, 05 May 2023 19:47:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pv1OV-00Bf1j-2a
	for kexec@lists.infradead.org;
	Fri, 05 May 2023 19:47:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3762A60F93;
	Fri,  5 May 2023 19:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD1EC433EF;
	Fri,  5 May 2023 19:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683316026;
	bh=Sb2KgQ5DsUgQ8xKWmkYNMl26e38BQYOVMpl/Vac7Mlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elsCHSqNwFxUfu6VDPA5BgwMa9uPCAgvGK/9pAW2TU5GB9bI3Ll6zAfgwLZ0x/r5R
	 IluW+zvNltdv9tF/cWmtu/jBRAAqCK5t2m8FHh2N6sAIIyhxca/kBfj26fVEeoWd2L
	 A2r85aEVAIz5tUkrO73+HjZlYFK2Hmh7eFe7uuLwvJg4PXMsc+efjVhtqEnrcUOG3P
	 ULB+CdNJnc7D3UqmB9EY104YZbopRSB4H5PLwfM4gBQWbRTiDjSNdEafQuGCZngOO3
	 ZJ/Sv/PL7t1UG3pd7QfV1iPUyhYqUn3e6R7gLh6KK4sIutQOZ+ihxN1XWeAU8Hc+Y7
	 F5IdlWXYgma6Q==
Date: Fri, 5 May 2023 21:46:56 +0200
From: Simon Horman <horms@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, luto@amacapital.net,
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 07/14] x86: Secure Launch kernel early boot stub
Message-ID: <ZFVdMJIQ+4BmXvhN@kernel.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-8-ross.philipson@oracle.com>
 <ZFVBLCLVK7AAStst@kernel.org>
 <81ce947c-07a0-0975-1d09-776fb03c64b9@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <81ce947c-07a0-0975-1d09-776fb03c64b9@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_124707_886701_67CC8B06 
X-CRM114-Status: GOOD (  22.78  )
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

On Fri, May 05, 2023 at 02:58:28PM -0400, Ross Philipson wrote:
> On 5/5/23 13:47, Simon Horman wrote:
> > On Thu, May 04, 2023 at 02:50:16PM +0000, Ross Philipson wrote:

...

> > > +asmlinkage __visible void sl_check_region(void *base, u32 size)
> > > +{
> > > +	sl_check_pmr_coverage(base, size, false);
> > > +}
> > 
> > I'm a nit unsure, what to do here, but clang-16 with W=1 says the following.
> > 
> > arch/x86/boot/compressed/sl_main.c:533:27: warning: no previous prototype for function 'sl_main' [-Wmissing-prototypes]
> > asmlinkage __visible void sl_main(void *bootparams)
> >                            ^
> > arch/x86/boot/compressed/sl_main.c:533:22: note: declare 'static' if the function is not intended to be used outside of this translation unit
> > asmlinkage __visible void sl_main(void *bootparams)
> >                       ^
> >                       static
> 
> Yea we will have to look into why this is. This function is only ever called
> from asm code so that might have something to do with this.

Thanks.

...

> > > diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> > > index 01d19fc..74e3e7df 100644
> > > --- a/arch/x86/include/uapi/asm/bootparam.h
> > > +++ b/arch/x86/include/uapi/asm/bootparam.h
> > > @@ -26,6 +26,7 @@
> > >   /* loadflags */
> > >   #define LOADED_HIGH	(1<<0)
> > >   #define KASLR_FLAG	(1<<1)
> > > +#define SLAUNCH_FLAG	(1<<2)
> > >   #define QUIET_FLAG	(1<<5)
> > >   #define KEEP_SEGMENTS	(1<<6)
> > >   #define CAN_USE_HEAP	(1<<7)
> > 
> > nit: please consider using BIT()
> 
> I am a little reluctant to change something like this in an existing header.
> It seems a bit out of scope for the patch set.

Yes, sorry for the noise on this one.
I agree that what you have is the best approach here.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
