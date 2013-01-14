Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TupKn-0001uG-Ul
 for kexec@lists.infradead.org; Mon, 14 Jan 2013 19:04:39 +0000
Received: by mail-bk0-f48.google.com with SMTP id jc3so2197291bkc.35
 for <kexec@lists.infradead.org>; Mon, 14 Jan 2013 11:04:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201301141605.43428.trenn@suse.de>
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
 <2741365.qqWvlU8HGl@hammer82.arch.suse.de>
 <CAE9FiQV+W21WcZuuWJYJKXhN4sf0mi=iAFgjX644c3EytPXptw@mail.gmail.com>
 <201301141605.43428.trenn@suse.de>
Date: Mon, 14 Jan 2013 11:04:36 -0800
Message-ID: <CAE9FiQVQvj1TPokoCgx_jbp0VACC8cgtFibH4KoqOssEc6JSPw@mail.gmail.com>
Subject: Re: [PATCH] x86 e820: only void usable memory areas in
 memmap=exactmap case
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
To: Thomas Renninger <trenn@suse.de>
Cc: horms@verge.net.au, Takao Indoh <indou.takao@jp.fujitsu.com>, MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>, tokunaga.keiich@jp.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, "H. Peter Anvin" <hpa@zytor.com>, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

On Mon, Jan 14, 2013 at 7:05 AM, Thomas Renninger <trenn@suse.de> wrote:
> What is this for?:
> @@ -871,6 +879,11 @@ static int __init parse_memmap_one(char
>         userdef = 1;
>         if (*p == '@') {
>                 start_at = memparse(p+1, &p);
> +               if (exactusablemap_parsed) {
> +                       /* remove all range with other types */
> +                       e820_remove_range(start_at, mem_size,
> +                                                E820_RAM, 0);
> +               }
>                 e820_add_region(start_at, mem_size, E820_RAM);
>         } else if (*p == '#') {
>                 start_at = memparse(p+1, &p);

remove all old renges before add E820_RAM, otherwise new add E820
ranges could be ignored.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
