Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-f53.google.com ([209.85.214.53])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dLmio-0006Ed-Vi
 for kexec@lists.infradead.org; Fri, 16 Jun 2017 08:35:16 +0000
Received: by mail-it0-f53.google.com with SMTP id m47so31313615iti.1
 for <kexec@lists.infradead.org>; Fri, 16 Jun 2017 01:34:54 -0700 (PDT)
Subject: Re: makedumpfile: support for newer kernels [v4.9 onwards]
References: <CAEzMDiD-w91Q+Fjy_KgXDcwo9YGasa9ggqW2dEhF4ffV7RstqQ@mail.gmail.com>
 <0bd0a35a-88cd-3f68-846f-2a2ad1e7afcb@redhat.com>
 <CAEzMDiBKdA15Gn2kgs=BgzCM=bzaBXCQP_tM_Vmfc4uxGL0SRg@mail.gmail.com>
 <0ae1e066-821e-3b11-ee44-b615245cb1ea@redhat.com>
 <3b72a75c-012e-2779-74a4-d36ca1ef9e56@redhat.com>
 <CAEzMDiARnp-FMqUcoVdCBSSApaRbenvrk7cawgyo8kJJvy0jXg@mail.gmail.com>
 <364d6133-158b-0f28-0278-dc0da33b2916@redhat.com>
 <CAEzMDiAq1U3SRkvwh5nqETDBoZs8DojhmMTDSG7B-Uzbh1a3Nw@mail.gmail.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <148b498a-cd13-bcb2-de04-d74b1c2a0f65@redhat.com>
Date: Fri, 16 Jun 2017 14:04:49 +0530
MIME-Version: 1.0
In-Reply-To: <CAEzMDiAq1U3SRkvwh5nqETDBoZs8DojhmMTDSG7B-Uzbh1a3Nw@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Abhishek Shah <abrs612@gmail.com>
Cc: Dave Anderson <anderson@redhat.com>, ats-kumagai@wm.jp.nec.com, "kexec@lists.infradead.org" <kexec@lists.infradead.org>



On Tuesday 13 June 2017 08:47 PM, Abhishek Shah wrote:
> @Pratyush, Thanks for testing and verifying the kernel configuration
> for arm64 makedumpfile.
> When you say things were working fine for you,  what exact
> makedumpfile command did you use??

makedumpfile -l --message-level 1 -d 31 /proc/vmcore /var/crash/vmcore

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
