Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dIqV3-00073T-0Y
 for kexec@lists.infradead.org; Thu, 08 Jun 2017 06:00:54 +0000
Received: by mail-qt0-x242.google.com with SMTP id o21so6078518qtb.1
 for <kexec@lists.infradead.org>; Wed, 07 Jun 2017 23:00:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3b72a75c-012e-2779-74a4-d36ca1ef9e56@redhat.com>
References: <CAEzMDiD-w91Q+Fjy_KgXDcwo9YGasa9ggqW2dEhF4ffV7RstqQ@mail.gmail.com>
 <0bd0a35a-88cd-3f68-846f-2a2ad1e7afcb@redhat.com>
 <CAEzMDiBKdA15Gn2kgs=BgzCM=bzaBXCQP_tM_Vmfc4uxGL0SRg@mail.gmail.com>
 <0ae1e066-821e-3b11-ee44-b615245cb1ea@redhat.com>
 <3b72a75c-012e-2779-74a4-d36ca1ef9e56@redhat.com>
From: Abhishek Shah <abrs612@gmail.com>
Date: Thu, 8 Jun 2017 11:30:31 +0530
Message-ID: <CAEzMDiARnp-FMqUcoVdCBSSApaRbenvrk7cawgyo8kJJvy0jXg@mail.gmail.com>
Subject: Re: makedumpfile: support for newer kernels [v4.9 onwards]
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
To: Pratyush Anand <panand@redhat.com>
Cc: ats-kumagai@wm.jp.nec.com, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Pratyush,

>>> I am using yocto(2.3 version) to build makedumpfile, which fetches v1.6.1
>>> makedumpfile and also applys some patches including arm64 specific
>>> patches.
>
>
> What are these ARM64 specific patches? I believe, you do not need any topup
> in makedumpfile for ARM64 if you use v1.6.1.

Sorry, I got confused with yocto kexec recipe.
There are NO arm64 specific patches in yocto for makedumpfile.

>>> We have VA_BITS set as 48 bits... I will get other information and post
>>> on the
>>> list.
>
>
> OK.
>
Kernel config:
ARM64_VA_BITS_48 [=y]
ARM64_PAGE_SHIFT [=12]
RANDOMIZE_BASE [=n]
ARM64_4K_PAGES [=y]

Regards,
Abhishek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
