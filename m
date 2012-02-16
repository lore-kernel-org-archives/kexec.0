Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yx0-f177.google.com ([209.85.213.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Ry6IO-00028x-Af
 for kexec@lists.infradead.org; Thu, 16 Feb 2012 18:43:08 +0000
Received: by yenm4 with SMTP id m4so1611457yen.36
 for <kexec@lists.infradead.org>; Thu, 16 Feb 2012 10:43:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120216025331.GT9751@redhat.com>
References: <tip-d9bc9be89629445758670220787683e37c93f6c1@git.kernel.org>
 <CAE9FiQWRjvu_uNcx_bJXYHeg4D4k6YzHHmSudsq7EyubLi7+nw@mail.gmail.com>
 <20120213152808.GD9751@redhat.com>
 <CAE9FiQXX7BXKuVHZ9NRCEmeTnPj4zVJL5gf5eSp6b+4e3jN3EA@mail.gmail.com>
 <20120216025331.GT9751@redhat.com>
Date: Thu, 16 Feb 2012 10:43:06 -0800
Message-ID: <CAE9FiQW4utm0roHR7zHS_tHbOAhqi4SECjH8cwJ3H=zEKhQLXA@mail.gmail.com>
Subject: Re: [tip:x86/debug] x86/kdump: No need to disable ioapic/ lapic in
 crash path
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
To: Don Zickus <dzickus@redhat.com>
Cc: linux-tip-commits@vger.kernel.org, mingo@elte.hu, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, tglx@linutronix.de, vgoyal@redhat.com

On Wed, Feb 15, 2012 at 6:53 PM, Don Zickus <dzickus@redhat.com> wrote:
>
> For some reason using gzip instead of xz makes things work for me with
> your config.
>
> CONFIG_KERNEL_GZIP=y
> CONFIG_KERNEL_XZ=n
>
> Do you see the same thing?

no.

with GZIP still get instant reset.

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
