Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pd0-x235.google.com ([2607:f8b0:400e:c02::235])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMuvz-00016Y-P3
 for kexec@lists.infradead.org; Fri, 20 Sep 2013 07:15:24 +0000
Received: by mail-pd0-f181.google.com with SMTP id g10so58004pdj.12
 for <kexec@lists.infradead.org>; Fri, 20 Sep 2013 00:15:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130919210750.GH2918@verge.net.au>
References: <1379412095-7213-1-git-send-email-geert@linux-m68k.org>
 <20130919210750.GH2918@verge.net.au>
Date: Fri, 20 Sep 2013 09:15:02 +0200
Message-ID: <CAMuHMdVx3KmL9cK-_g3qcrkHxxCAno+3z4O=kVTOGCYhD_WmWw@mail.gmail.com>
Subject: Re: Preliminary kexec support for Linux/m68k
From: Geert Uytterhoeven <geert@linux-m68k.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Simon,

Thanks for your comments!

On Thu, Sep 19, 2013 at 11:07 PM, Simon Horman <horms@verge.net.au> wrote:
> Pasting two series in one was a bit confusing for me at first.
> Perhaps you could consider posting two separate series in future.

Sorry, I wanted to have all information in one series for the first posting, to
avoid people having to look around too much if they want to give it a try.

I'll post seperate series in the future.

>> Patches:
>>   - [PATCH 1/2] kexec: Let slurp_file_len() return the number of bytes
>>   - [PATCH 2/2] kexec: Add preliminary m68k support
>>
>> Notes:
>>   - Based on git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
>
> A good choice.

Is it normal I don't see much activity there?

>>   - The ramdisk is loaded at the top of memory minus 4096, unlike with
>>     m68boot (ataboot/amiboot), as locate_hole() seems to have a bug that it
>>     cannot reserve a block at the real top of memory.
>
> Is this a bug that could be fixed?

Possibly. I suspect an off-by-one bug somewhere, but I haven't looked deeply
into it.

>>   - Do we want to check the struct bootversion at the start of the kernel,
>>     like m68kboot does?
>>     Kexec may be used to load ELF files that are not Linux kernel images,
>>     and thus don't have a Linux-specific struct bootversion.
>
> If the check can sanely be skipped for non Linux kernel images then
> this sounds like a reasonable idea to me. Otherwise I would lean towards
> omitting it. Either way, I don't feel strongly about this.
>
>>   - Do we want to check the size of the kernel image + bootinfo, and warn the
>>     user if it's larger than 4 MiB?
>>     This is a limitation of the current Linux/m68k kernel only.
>
> I think that sounds like a good idea but I don't feel strongly about it.

Currently I'm leaning towards just printing a warning for both
(missing/incompatible
bootversion and image-too-large).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
