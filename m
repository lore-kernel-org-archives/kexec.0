Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tgy9z-0007Hh-0O
 for kexec@lists.infradead.org; Fri, 07 Dec 2012 13:40:12 +0000
Received: by mail-ob0-f177.google.com with SMTP id uo13so389485obb.36
 for <kexec@lists.infradead.org>; Fri, 07 Dec 2012 05:40:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOJsxLFy5TP_xJ0GcqYdpsZ_Lj+Sf2Bfn99CqCqOv8P21N8+UA@mail.gmail.com>
References: <1354810175-4338-1-git-send-email-js1304@gmail.com>
 <1354810175-4338-2-git-send-email-js1304@gmail.com>
 <CAOJsxLFy5TP_xJ0GcqYdpsZ_Lj+Sf2Bfn99CqCqOv8P21N8+UA@mail.gmail.com>
Date: Fri, 7 Dec 2012 22:40:10 +0900
Message-ID: <CAAmzW4PDmL-1U6SVFohS_du-7uJngbR-4EBa4UUSWa-xs66Lmw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/8] mm,
 vmalloc: change iterating a vmlist to find_vm_area()
From: JoonSoo Kim <js1304@gmail.com>
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
To: Pekka Enberg <penberg@kernel.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>

Hello, Pekka.

2012/12/7 Pekka Enberg <penberg@kernel.org>:
> On Thu, Dec 6, 2012 at 6:09 PM, Joonsoo Kim <js1304@gmail.com> wrote:
>> The purpose of iterating a vmlist is finding vm area with specific
>> virtual address. find_vm_area() is provided for this purpose
>> and more efficient, because it uses a rbtree.
>> So change it.
>
> You no longer take the 'vmlist_lock'. This is safe, because...?

As Bob mentioned, find_vm_area() hold a 'vmap_area_lock' during
searching a area.
When we hold a 'vmap_area_lock', area can't be removed.
So this change is safe.

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
