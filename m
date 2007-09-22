Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from barikada.upol.cz ([158.194.242.200])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IZDvf-00039Y-De
	for kexec@lists.infradead.org; Sat, 22 Sep 2007 18:58:31 -0400
Subject: Re: [patch 1/7] Extended crashkernel command line
In-Reply-To: <20070920171846.062209000@stravinsky.suse.de>
References: <20070920171845.774383000@stravinsky.suse.de>
	<20070920171846.062209000@stravinsky.suse.de>
Date: Sun, 23 Sep 2007 01:14:00 +0200
Message-Id: <E1IZEAi-00051i-23@flower>
From: Oleg Verych <olecom@flower.upol.cz>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

* Thu, 20 Sep 2007 19:18:46 +0200

[]
>  extern u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
>  extern unsigned int vmcoreinfo_size;
>  extern unsigned int vmcoreinfo_max_size;
> +int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
> +		unsigned long long *crash_size, unsigned long long *crash_base);

(BTW, why `system_ram' is `unsigned long' in parse_crashkernel_mem() but
`unsigned long long' in parse_crashkernel()?)

> +static int __init parse_crashkernel_mem(char 			*cmdline,
> +					unsigned long 		system_ram,
> +					unsigned long long 	*crash_size,
> +					unsigned long long 	*crash_base)
> +{
> +	char *cur = cmdline;
> +
> +	/* for each entry of the comma-separated list */
> +	do {
> +		unsigned long long start = 0, end = ULLONG_MAX;
> +		unsigned long long size = -1;
[]

What is the point of not using `ulong' and `u64'?

What about another names?

 +int __init get_crashkernel_params(u64 *memsize, u64 *addrbase, char *cmdline, u64 ram);
_____

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
