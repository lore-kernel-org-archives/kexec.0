Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SyVHJ-0005jo-T0
 for kexec@lists.infradead.org; Mon, 06 Aug 2012 21:55:59 +0000
Received: by vcbfl13 with SMTP id fl13so3201390vcb.36
 for <kexec@lists.infradead.org>; Mon, 06 Aug 2012 14:55:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120806204245.GI25559@redhat.com>
References: <1339478463-31172-1-git-send-email-amwang@redhat.com>
 <5004D8BF.6050205@jp.fujitsu.com> <500D20A1.1030800@redhat.com>
 <500D340F.5080801@jp.fujitsu.com> <1343145331.16290.45.camel@cr0>
 <500F3B7C.70009@jp.fujitsu.com> <20120806204245.GI25559@redhat.com>
Date: Mon, 6 Aug 2012 14:55:55 -0700
Message-ID: <CAE9FiQW1AiKPVsesmQD5yTk1+4w56pkcDrsRo2yZThuB+2bsOQ@mail.gmail.com>
Subject: Re: [PATCH] x86: revert "x86: Fix S4 regression"
From: Yinghai Lu <yinghai@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>, Ingo Molnar <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, amwang@redhat.com, tiwai@suse.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, xiyou.wangcong@gmail.com, akpm@linux-foundation.org, dyoung@redhat.com

On Mon, Aug 6, 2012 at 1:42 PM, Vivek Goyal <vgoyal@redhat.com> wrote:

>
> Did something happen on this patch. We definitely want to gain back the
> capability to be able to reserve 512MB of kdump memory.

Maybe Ingo and peter could push that to Linus.

Assume we have Acked-by from you, me and others.

Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
