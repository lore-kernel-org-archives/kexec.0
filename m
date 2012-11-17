Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZpM5-00062c-3k
 for kexec@lists.infradead.org; Sat, 17 Nov 2012 20:51:10 +0000
Received: by mail-bk0-f49.google.com with SMTP id jm19so312248bkc.36
 for <kexec@lists.infradead.org>; Sat, 17 Nov 2012 12:51:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6eadd4ad-0e3f-4670-81a8-38beb9354e01@email.android.com>
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
 <1353107067-14564-4-git-send-email-yinghai@kernel.org>
 <87haoo21mw.fsf@xmission.com>
 <CAE9FiQU=tW51h_NL+_AGQMDhNRM1dBCTW1FJVe6vpQYVQEzY=Q@mail.gmail.com>
 <87fw48zldz.fsf@xmission.com>
 <CAE9FiQVX8xnAGGkPtR0BA1iYbQi5fXY2+P3pW=d-tX8fpWibnw@mail.gmail.com>
 <6eadd4ad-0e3f-4670-81a8-38beb9354e01@email.android.com>
Date: Sat, 17 Nov 2012 12:51:06 -0800
Message-ID: <CAE9FiQX8BD2VNnPXHnHYGowsS02czk3e+vLttuDpcaiZ3bDcLA@mail.gmail.com>
Subject: Re: [PATCH 3/8] add mem64_min/max control
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Sat, Nov 17, 2012 at 12:41 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> Sorry, with "real mode" are we talking about struct boot_params or the actual realmode trampoline?  The latter needs to be < 640K as a hw requirement.

boot_params.

when kexec bzImage64, kexec will copy that from bzImage file, and
update it....and
pass pointer to arch/x86/boot/compressed/head_64.c via %rsi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
