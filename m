Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knxUB-00021W-FC
 for kexec@lists.infradead.org; Sat, 12 Dec 2020 05:30:28 +0000
Received: by mail-il1-x12b.google.com with SMTP id y9so10880488ilb.0
 for <kexec@lists.infradead.org>; Fri, 11 Dec 2020 21:30:25 -0800 (PST)
MIME-Version: 1.0
References: <CAOXnu2jMX2HtL_U0MoLAy9+x_7eL=U7vHJfLo6WWAWStB2BkSg@mail.gmail.com>
In-Reply-To: <CAOXnu2jMX2HtL_U0MoLAy9+x_7eL=U7vHJfLo6WWAWStB2BkSg@mail.gmail.com>
From: Kazuhito Hagio <kazuhito.hagio@gmail.com>
Date: Sat, 12 Dec 2020 14:30:12 +0900
Message-ID: <CAC4uBbKtue-FzRUNrqJD1gcrACOseUTKheJvPn-w3-DaMsNgoA@mail.gmail.com>
Subject: Re: makedumpfile and tmpfs contents
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
To: Rajendra Dendukuri <rajendra.dendukuri@broadcom.com>
Cc: kexec@lists.infradead.org

Hi Rajen,

On Fri, Dec 11, 2020 at 11:36 PM Rajendra Dendukuri
<rajendra.dendukuri@broadcom.com> wrote:
>
> Hi,
>
> Is there a possibility or an option to recover contents of a tmpfs by
> the crashkernel after the original kernel has kdump'ed. The idea is to
> store a few other system log files stored in a tmpfs similar to how
> dmesg logs are recovered. Any other ideas to solve this requirement?

I think it would be too hard for makedumpfile to do this, but if you can use
the crash utility to extract contents of a tmpfs from a vmcore, my "cacheutils"
crash extension module [1] might be useful, since tmpfs uses page cache.

[1] https://github.com/k-hagio/crash-cacheutils

Thanks,
Kazu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
