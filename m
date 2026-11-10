Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A9D606A31C
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=y+R5BeG2;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lH55KQox
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=k9yi/N1AYK9b/IG90nWQLSGZSs607NH+SzJ8udDeO1o=; b=y+R5BeG2B0XAOt5v2jloqZtYJA
	HXRzFgJnHAdz/Fg53+WzIdgHuPx/1tpC1IORQoUlwCjdpiw2i7UHTEkzjDsZKH+31CV2asz81oj30
	eT+j67+kx+o9YY/rxuDDmze0G2/K9r4AyUbtuaewH1rovXdQUL455mN9Y0fsRbbkHIEeb1KpHxjBP
	1pRZLgT/Z1sE9Hu3CnmU30MWPdqdy17vP1nFmFqpywNmcxg238bExDsUwNVLj+RPEhYn4GsTngw9+
	Osie/0ectAJ+mI2+ipx7mjEWiM56a11Bu2XJPsWarSuLm/zWPZjXkuxhBnBQYotUxkmvSOUF9MTer
	nufDyxbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQjvK-00000003c7O-09rF;
	Tue, 10 Nov 2026 11:21:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQjvI-00000003c79-2q2u
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 11:21:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F29F943082;
	Tue, 10 Nov 2026 11:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2636E1F0089F;
	Tue, 10 Nov 2026 11:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794309714;
	bh=k9yi/N1AYK9b/IG90nWQLSGZSs607NH+SzJ8udDeO1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lH55KQox2zN2fQ3Q6koV8USfZ23vClcroYNiHKMQBEClvlWtCtdxyTDgDMKE4b6jY
	 ihHG8RYh92uGEFJ7XbfpvhKhm5eFj52nPX5ggzpiuf6+rGRoD90DyDBqkhD+/qpNsD
	 dJvj9wnWZ3Onn1jCtl7UdHuSKdSnBJc9QoqDGWGWlKp4Fg7xvDA+MXap3wMyyDu06O
	 1PaTmdzjvJdGesb9Xej/82oKhdx26KPCS26jGx3RRlxTNaV78iIuKR9nWl9taFLqjg
	 l0kHtG8AmlfiEptRW1BNKuwHWrxpuSFFiT8NKF/+6id6eJCSHAkLzTyMgmOgf6Tg3j
	 SrlhRKGxkF+nA==
Date: Tue, 10 Nov 2026 11:21:51 +0000
From: Simon Horman <horms@kernel.org>
To: zhangzikang1992@126.com
Cc: kexec@lists.infradead.org, zhangzikang <zhangzikang@kylinos.cn>
Subject: Re: [PATCH] kexec: fix stack buffer overflow in update_purgatory()
Message-ID: <20261110112151.GA330449@horms.kernel.org>
References: <20261030030917.103293-1-zhangzikang1992@126.com>
 <20261110105841.GA1320297@horms.kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110105841.GA1320297@horms.kernel.org>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 10:58:41AM +0000, Simon Horman wrote:
> On Fri, Oct 30, 2026 at 11:09:18AM +0800, zhangzikang1992@126.com wrote:
> > From: zhangzikang <zhangzikang@kylinos.cn>
> > 
> > Problem:
> > A stack buffer overflow exists in "update_purgatory()". The local array "sha256_region region[SHA256_REGIONS]" (size 16) is written during iteration over "info->nr_segments" without boundary checking for the write index "j".
> > 
> > "Add_degment_phys-virt()" only issues a warning when "nr_degments" exceeds "KEXEC_MAX_SGMENTS" (=16) and continues to append segments. Therefore, "update_purgation()" may be called, causing "nr_degments" to be much larger than "SHA256-REGIONS", resulting in "region [j]" being written outside of the 16 item stack array. This type of out of bounds write will damage the Canary stack and adjacent stack frames.
> > 
> > Impact:
> > Stack buffer overflow causing process crash (resulting in denial of service through Canary termination); The potential for controllable stack destruction depends on the content of the image.
> > 
> > Fix:
> > Before writing to "region[j]" in "update_purgatory()", add a bounds check on "j" to ensure that writing stops immediately when "j" reaches "SHA256_REGIONS", preventing out-of-bounds writes from corrupting adjacent global variables.
> > 
> > Signed-off-by: zhangzikang <zhangzikang@kylinos.cn>
> > ---
> >  kexec/kexec.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/kexec/kexec.c b/kexec/kexec.c
> > index c9e4bcb..732058e 100644
> > --- a/kexec/kexec.c
> > +++ b/kexec/kexec.c
> > @@ -728,6 +728,11 @@ static void update_purgatory(struct kexec_info *info)
> >  			sha256_update(&ctx, null_buf, bytes);
> >  			nullsz -= bytes;
> >  		}
> > +		if (j >= SHA256_REGIONS) {
> > +			fprintf(stderr, "Warning: SHA256 region limit reached. "
> > +				"Skipping remaining segments from checksum region list\n");
> > +			break;
> > +		}
> >  		region[j].start = (unsigned long) info->segment[i].mem;
> >  		region[j].len   = info->segment[i].memsz;
> >  		j++;
> 
> Hi Zikang,
> 
> Thanks for your patch. I agree this is a bug.
> And that your patch avoids kexec-tools crashing
> 
> However, I think by skipping regions as your patch proposes we move the
> burden of failing what is an invalid operation to the load call, which will
> fail because the Kernel enforces a 16 segment limit. And, moreover, it's
> probably not best to create a mismatch between the calculated digest and
> the populated regions, which appears to be possible with your patch.
> 
> What I would suggest is this:
> 
> 1. Add a segment limit check to add_segment_phys_virt,
>    logging an error and returning -1 if the check fails.
> 
> 2. As a failsafe mechanism, add a check to update_purgatory,
>    but place it as early in the loop as possible, and
>    call die() rather than just logging an error and continuing.

Hi again,

I tried to code-up my own suggestion and realised that point 1 was
slightly off the mark: add_segment_phys_virt doesn't have a return value,
and there is already a segment check present.

I think what would be best is to move the check, because it seems
to come too late to avoid a possible overrun within that function,
and die() if the check fails.

Something like this:

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 99ec3ff3c373..b1d2b595682e 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -363,6 +363,10 @@ void add_segment_phys_virt(struct kexec_info *info,
 			(void *)base, (void *)last);
 	}
 
+	if (info->nr_segments >= KEXEC_MAX_SEGMENTS) {
+		die("Kernel segment limit reached.\n");
+	}
+
 	size = (info->nr_segments + 1) * sizeof(info->segment[0]);
 	info->segment = xrealloc(info->segment, size);
 	info->segment[info->nr_segments].buf   = buf;
@@ -370,10 +374,6 @@ void add_segment_phys_virt(struct kexec_info *info,
 	info->segment[info->nr_segments].mem   = (void *)base;
 	info->segment[info->nr_segments].memsz = memsz;
 	info->nr_segments++;
-	if (info->nr_segments > KEXEC_MAX_SEGMENTS) {
-		fprintf(stderr, "Warning: kernel segment limit reached. "
-			"This will likely fail\n");
-	}
 }
 
 unsigned long add_buffer_phys_virt(struct kexec_info *info,
@@ -718,6 +718,10 @@ static void update_purgatory(struct kexec_info *info)
 			continue;
 		}
 
+		if (j >= SHA256_REGIONS) {
+			die("update_purgatory: Exceeded maximum SHA256 regions\n");
+		}
+
 		sha256_update(&ctx, info->segment[i].buf,
 			      info->segment[i].bufsz);
 		nullsz = info->segment[i].memsz - info->segment[i].bufsz;

