Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF06CC43458
	for <kexec@archiver.kernel.org>; Sat,  4 Jul 2026 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wA1liI19oI1AkBerychf4m2LDUMb0gUS762S3f5S9h0=; b=dG3PaFF0cw8nUuUCqPaV0dW1ll
	PXlUdkQ+xk1WYeRi2DXpMozDOj0fblDsV9mSLfZt7Bqpk00O0DB4o0qH/0mBt9qTenupuuc/Z+U5q
	NiWu81pbF8RNyFRCZcDRibO64vCgnY/T7XExXww/vd9ubfO0Qk/+jCWl6MI0YyR70JzvAZVO54vlg
	XimdOBESog+S5QoedrTXTDvd2DdDNuncgZ9UjgVq2BFMO8x/DVJmh7sGWqlmSXTxzZj8phIHGHTUO
	EaeLE43JG+IqazOiq4+9gqi9lcaaFCS6fKRselDkq+wvINFqKPBSM5Q3CNS8rgI8E5RM2bymHiqoF
	t7hz9cGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfyWm-00000008Nsh-0xlI;
	Sat, 04 Jul 2026 11:27:20 +0000
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfyWj-00000008NsI-14ez
	for kexec@lists.infradead.org;
	Sat, 04 Jul 2026 11:27:18 +0000
Received: by mail-yx1-xb129.google.com with SMTP id 956f58d0204a3-664d4478a64so1813274d50.3
        for <kexec@lists.infradead.org>; Sat, 04 Jul 2026 04:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783164435; cv=none;
        d=google.com; s=arc-20260327;
        b=GjDWX2O57cXcftoOPVTilOT2UCnq9JLayr639VtAF0ThH1h7wNNcyXVS1s/NuyvwG/
         at8GpOJ3rN/gTQweFFlBFFdWl8ub/9wE3r6M74LOOIK4mnuT/EQ20KYpdOdtmwiZv8eO
         kR2VGwDbwBMWxEDXOXWdprkdk3DeUw+g2ymiyReGbv0eJH6eVvEm9c7JTS3W8pQZImpx
         6FSshV3yDNHW8G0VfDh+QjhqlULukpjtUgbcAoFnwt54ncfpb+inhF5ihdgF/z2U1MlR
         RWlUhsc4kxUO4YQyoI80MFEJ1Ju0l82pUfPK/3n8/3Xg4fHjRjxu7oIcUwDMEHiejEcG
         asbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wA1liI19oI1AkBerychf4m2LDUMb0gUS762S3f5S9h0=;
        fh=pFyNGdug5aa+u9hJ1N0AT0guJmaCkG0gMVtqOyM1ywg=;
        b=icwkj8Ifi/v7l33EEfNR/6STVwsQWaiQGA8oJi/NvreJodN+SynfWTQqPwQy3kmXcz
         lAJJ+LjG7BmMTV3hnX1jVmKDjJs5kRKaScxK9uJJK0zwrNLniA17wV/WMT9ugopyKl3q
         Z3PCf74KL0bSX6hER8nb4oUMKuOhwzkGPreL2eKW0S6gmUGs7CTiXSej+NpTH5dcxOWh
         zySEi7lL567UbngostzY3225sZBZ2SRL3nLKq62APL0CQ2zMZ4uyNVh3imZS42aP+kYn
         jQIlTTSDscCQBzVQp6+H7h27DyWj74z2SyTIhjeLzBUpuXWJt2j4mblWZkiSGitVOs+w
         J3/Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783164435; x=1783769235; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wA1liI19oI1AkBerychf4m2LDUMb0gUS762S3f5S9h0=;
        b=Moj328Q6f1Sd0cv4dXxmCSI4uxmNPb55jk2we+ov3B5AEJe0jwgvXLTDNE60Gnwm6b
         R0fXfM2BBbv8COZEuCpd2dSa4qsWaoJjuhW1TMgKJxQQPHounfY5lGgbe/5tfQ5kOvGZ
         TDX1kVsqQdNOHVpkSPGWK0O0HGvy1MIgL5x6nFVYmx8tDCChS3BtUzgriJtL7jOCs1Tc
         FxdAWQwMpXZtgMepjyJwZyVHwQdm1zLSsq9qlxLCI8X8REquZfc1ubrA71/4kJmxcmAW
         r/neeM4XXs3YbGdfBl5t5XEWatghtF38XV0QABTO0yfHtKg++sWcVf53kjXEX2fncvU3
         1hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783164435; x=1783769235;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wA1liI19oI1AkBerychf4m2LDUMb0gUS762S3f5S9h0=;
        b=q7DoQwFE5mUpl4RtunjHmlYorUI3Ip2Z59bc0qeosPrMVZufzrThZ8rgTso/i+zStk
         CqyWB0g8R65MEegN5AGpMqNM0oPFclatgixe/puUAPKbpjlaraFAZ8VHEeFI6no+hk5Y
         dW3NAcbcJs7Z97SoP1651SIh4LU3s2sQaK41fNj8BANz2bLQFxeTXBdDzviV2glCIjQb
         uNw9Xo5QTLpOh0aJEWCFTBgwb6E6YqT5WgqNTM6PHlfjGGiqAJXqERIFjlK4EOknFLR5
         ZOVOilvQbQTbERbTUao2iDmh7uh65iBXav2TYLl+9QuqORsvCl7akxLQjIwvYwP3cqUl
         /aNg==
X-Forwarded-Encrypted: i=1; AHgh+RruEfhJUta+AT4XO78yay0j5ZWVY6fV6/7B1xk5V2aDEPSWtI/0hDp/khzp8Dm2KFubNk1PBg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzVlewcl7Wu6jtRToEMN4kgbKKR03r2kyJaFsPi0P/qOgLfGpuM
	t2IcPVG+ejsMXw4dXa63UwtLs9EN3TffCi+Wv3zb8UlYmLy4LZ4qbRGf8fzKcSISdLBo41OM2oX
	CZB9U/OoQxCxFSJdLnfNtfI9l9iTkGU8=
X-Gm-Gg: AfdE7clHL3xmVpXN8jHVpP4ZmQ4rF/bPiR5QWPhCraTlSu+6ZrERH/Tctp7+fSdb1kt
	94ytRS3mB/2YwNqVKqMAZ7niaaGz0sMHdemgk7H45eMRq4NFjur/nelS19QyAeYg4PSDmX33TLF
	G6bYj1bTrsYjqykbCGTzgGXpcOyyLpMU6i+KI1Y/4XSxfAvRME43ZlPy/7UWI6dztVoljAOY8Jc
	OJ/A9XfQCJHtpvHOohG46JeXptNNckv9jdVzWIQujbz+c3dNYRbHs5DT+uZJwdbV7vzpOLm
X-Received: by 2002:a05:690e:11c3:b0:651:c160:1c06 with SMTP id
 956f58d0204a3-66653067b6dmr2427087d50.58.1783164435060; Sat, 04 Jul 2026
 04:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260603135056.1397084-1-lgs201920130244@gmail.com> <aj0Ai72gTkrorkYI@Rk>
In-Reply-To: <aj0Ai72gTkrorkYI@Rk>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sat, 4 Jul 2026 19:27:04 +0800
X-Gm-Features: AVVi8CfLi6R3buAs7-cC_b0mbrjREceToWhY-HRrpCRsOapcuCMhET43E_XN5qs
Message-ID: <CANUHTR-NvXL+JHpojdVquu9JRzWxf2WUer_yQo5w00CA1TiS-w@mail.gmail.com>
Subject: Re: [PATCH] crash_dump: release keyring reference at the correct time
To: Coiby Xu <coiby.xu@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, 
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <ruirui.yang@linux.dev>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260704_042717_307040_17302420 
X-CRM114-Status: GOOD (  26.01  )
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

Hi Coiby,

Thanks for the review and for sharing the testing result.

On Thu, 25 Jun 2026 at 18:50, Coiby Xu <coiby.xu@gmail.com> wrote:
>
> Hi Guangshuo,
>
> Thanks for sending this patch! Your fix is more complete than my version
> https://lore.kernel.org/kexec/20260501234342.2518281-2-coiby.xu@gmail.com/
> So I plan to drop mine from the patch set. I only have some nitpicking
> for this patch. Please check inline comments.
>
> On Wed, Jun 03, 2026 at 09:50:56PM +0800, Guangshuo Li wrote:
> >restore_dm_crypt_keys_to_thread_keyring() gets a reference to the user
> >keyring before restoring the saved dm-crypt keys.
> >
> >The same keyring reference is then passed to add_key_to_keyring() for each
> >saved key, but add_key_to_keyring() drops that reference on every call.
> >This is only balanced when exactly one key is restored. With multiple
> >keys, the keyring reference is dropped too many times and may trigger a
> >refcount underflow or use-after-free.
>
> My testing shows when there are more than five keys to be added, this
> "refcount_t: underflow; use-after" error can occur. Maybe you can
> include this info in your commit msg.
>
> >
> >The early error paths after lookup_user_key() also return without dropping
> >the keyring reference.
> >
> >Keep ownership of the keyring reference in
> >restore_dm_crypt_keys_to_thread_keyring(), drop it once on all exit paths,
> >and make add_key_to_keyring() only use the reference without consuming it.
> >
> >Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
> >Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> >---
> > kernel/crash_dump_dm_crypt.c | 15 ++++++++++-----
> > 1 file changed, 10 insertions(+), 5 deletions(-)
> >
> >diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> >index a20d4097744a..641c290f1270 100644
> >--- a/kernel/crash_dump_dm_crypt.c
> >+++ b/kernel/crash_dump_dm_crypt.c
> >@@ -80,7 +80,6 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
> >               kexec_dprintk("Error when adding key");
> >       }
> >
> >-      key_ref_put(keyring_ref);
> >       return r;
> > }
> >
> >@@ -104,6 +103,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
> >       size_t keys_header_size;
> >       key_ref_t keyring_ref;
>
> I think ordering local variables from longest line length to shortest line
> length a.k.a Reverse Christmas Tree style is preferred i.e.
>      int ret = 0;
>      u64 addr;
>
>
> --
> Best regards,
> Coiby

I have sent v2 with the commit message updated to mention the refcount
underflow/use-after-free warning, and also fixed the local variable
ordering as suggested.

Thanks,
Guangshuo

