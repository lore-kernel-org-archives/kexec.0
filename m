Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZyWn-0001At-1o
 for kexec@lists.infradead.org; Sun, 18 Nov 2012 06:38:49 +0000
Received: by mail-bk0-f49.google.com with SMTP id jm19so356265bkc.36
 for <kexec@lists.infradead.org>; Sat, 17 Nov 2012 22:38:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <871ufrqw3d.fsf@xmission.com>
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
 <1353107067-14564-4-git-send-email-yinghai@kernel.org>
 <87haoo21mw.fsf@xmission.com>
 <CAE9FiQU=tW51h_NL+_AGQMDhNRM1dBCTW1FJVe6vpQYVQEzY=Q@mail.gmail.com>
 <87fw48zldz.fsf@xmission.com>
 <CAE9FiQVX8xnAGGkPtR0BA1iYbQi5fXY2+P3pW=d-tX8fpWibnw@mail.gmail.com>
 <CAE9FiQXNDEPw6WhfgYspqZsy+VVrPoA7M4kKo+5N95=22WBpkQ@mail.gmail.com>
 <50A86563.30303@zytor.com> <876253sej9.fsf@xmission.com>
 <CAE9FiQVfRHpoBoUyZssfE32wv7j3fD2skRL4UFXP=FBq7rrE1w@mail.gmail.com>
 <878v9zqyfh.fsf@xmission.com>
 <CAE9FiQV=6qeBgzd3ekBRXh1jfv+_-s_UuQqRyMAYwK5E=S55fA@mail.gmail.com>
 <CAE9FiQX7MsAaD4TaDv5gisuA5PNa9AmhDk54AjpzEzp4D_+aDg@mail.gmail.com>
 <CAE9FiQWm=6yas4dRfbc+qLC7yEhbdt+pnRMwAYSQ1jjk5qOvBw@mail.gmail.com>
 <871ufrqw3d.fsf@xmission.com>
Date: Sat, 17 Nov 2012 22:38:47 -0800
Message-ID: <CAE9FiQXGy_mxMWpf+7Jr-xVmxy6-_BGE2Ys9FbDk9U3A-kBfew@mail.gmail.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Sat, Nov 17, 2012 at 10:11 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Yinghai Lu <yinghai@kernel.org> writes:
>> so -mcmodel=large only work with .c, but does not have effects on .S ?
>
> Yes it -mcmodel=large is about which instructions you generate.  The
> instructions used determine the relocates.
>
> Just for playing with it the following patch modifies things so
> purgatory is 64bit clean.
>
> I don't know yet what to do with the 32bit and 16bit assembly.

so we should two purgatory for x86_64 ?
like one for 64bit and one for 32bit/16bit

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
