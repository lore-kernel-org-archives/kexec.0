Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TfhK8-0006G6-Bg
 for kexec@lists.infradead.org; Tue, 04 Dec 2012 01:29:25 +0000
Received: by mail-bk0-f49.google.com with SMTP id jm19so1328188bkc.36
 for <kexec@lists.infradead.org>; Mon, 03 Dec 2012 17:29:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87lide7gl4.fsf@xmission.com>
References: <87r4np4jm1.fsf@xmission.com>
 <CAE9FiQWvNYOfg1=uYYzdfoy5q6RnroNCVyqXRw2ffgLQp_UvFw@mail.gmail.com>
 <8738zm93je.fsf_-_@xmission.com>
 <20121204000908.GD15738@verge.net.au> <87txs27h9g.fsf@xmission.com>
 <CAE9FiQVc_3SC5JM497x3uPYyLqAyrOaRqocNNoZh98_5or1vzw@mail.gmail.com>
 <87lide7gl4.fsf@xmission.com>
Date: Mon, 3 Dec 2012 17:29:22 -0800
Message-ID: <CAE9FiQVbg3d=NLdWpKUd640C1cdW5FcF-AcZYyJtYVr++3G2Uw@mail.gmail.com>
Subject: Re: [PATCH] kexec: Teach configure to find the strip binary.
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
Cc: Simon Horman <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>

On Mon, Dec 3, 2012 at 5:26 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Yinghai Lu <yinghai@kernel.org> writes:
>>
>> STRIP = strip
>
> Run bootstrap.  At the very least it looks like you haven't regeneratged
> configure by running autoconf.

works. Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
