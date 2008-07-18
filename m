Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from py-out-1112.google.com ([64.233.166.182])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KJsix-0006PA-NS
	for kexec@lists.infradead.org; Fri, 18 Jul 2008 16:22:27 +0000
Received: by py-out-1112.google.com with SMTP id a73so511272pye.2
	for <kexec@lists.infradead.org>; Fri, 18 Jul 2008 09:22:27 -0700 (PDT)
Message-ID: <86802c440807180922l3500082chf7dcf0a1bafc6629@mail.gmail.com>
Date: Fri, 18 Jul 2008 09:22:26 -0700
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] x86: Move crashkernel reservation before
	dma32_reserve_bootmem()
In-Reply-To: <20080718115213.3c87f8f8@halley.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
References: <1216332945-17197-1-git-send-email-bwalle@suse.de>
	<86802c440807171550t360a2a76mddb9ae45c7e9f4fb@mail.gmail.com>
	<20080718115213.3c87f8f8@halley.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: akpm@linux-foundation.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

On Fri, Jul 18, 2008 at 2:52 AM, Bernhard Walle <bwalle@suse.de> wrote:
> * Yinghai Lu [2008-07-17 15:50]:
>>
>> > +       /*
>> > +        * dma32_reserve_bootmem() allocates bootmem which may conflict
>> > +        * with the crashkernel command line, so do that before
>> > +        */
>> > +       reserve_crashkernel();
>> > +
>> >  #ifdef CONFIG_X86_64
>> >        dma32_reserve_bootmem();
>> >  #endif
>> > @@ -808,7 +814,6 @@ void __init setup_arch(char **cmdline_p)
>> >         */
>> >        find_smp_config();
>> >  #endif
>> > -       reserve_crashkernel();
>> >
>> >        reserve_ibft_region();
>>
>> Joe Jin already had another one to move dma32_reserve_bootmem later
>
> Commit id? Current status?

it seems commit description from you is more good.
please create one version move dma32_reserve_boot_mem after
reserve_crashkernel and use your commit description.

YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
