Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TTYiB-0002fb-GL
 for kexec@lists.infradead.org; Wed, 31 Oct 2012 13:52:05 +0000
Message-ID: <50912CFB.5000508@hitachi.com>
Date: Wed, 31 Oct 2012 22:51:55 +0900
From: Mitsuhiro Tanino <mitsuhiro.tanino.gm@hitachi.com>
MIME-Version: 1.0
Subject: Re: [Patch 0/2] Exclude hwpoison page from vmcore dump
References: <508FDEF3.8030601@hitachi.com> <20121030143750.GF2290@redhat.com>
In-Reply-To: <20121030143750.GF2290@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

Hi Vivek,

(2012/10/30 23:37), Vivek Goyal wrote:
> Why to introduce this option "-p"? Until and unless there are serious
> side effects, this should be default functionality. Isn't it? Who would
> like to touch/save poisoned pages and run into MCE?

Thank you for your review of my patch.

In my understanding, hwpoison is a function which is only supported at
high end servers and most of users do not use this function.
Therefore, I think this functionality was better for option.

On the other hand, as you say, nobody wants to touch/save poisoned pages
and run into MCE, and it is desirable for users to exclude hwpoison pages
automatically. I agree with you.

I will post fixed patch without "-p" option. Please help to review it.

Subject: 
[PATCH 0/2 v2] Exclude hwpoison page from vmcore dump
[PATCH 1/2 v2] makedumpfile: Add a default action to exclude hwpoison page from vmcore
[PATCH 2/2 v2] kexec: Export PG_hwpoison flag into vmcoreinfo

Regards,
Mitshuhiro Tanino (mitsuhiro.tanino.gm@hitachi.com)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
