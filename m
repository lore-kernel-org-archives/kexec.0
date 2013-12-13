Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pb0-x22d.google.com ([2607:f8b0:400e:c01::22d])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VrNjC-0007iw-OH
 for kexec@lists.infradead.org; Fri, 13 Dec 2013 08:04:07 +0000
Received: by mail-pb0-f45.google.com with SMTP id rp16so2110345pbb.18
 for <kexec@lists.infradead.org>; Fri, 13 Dec 2013 00:03:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131213005322.GJ32101@verge.net.au>
References: <1381859460-13645-1-git-send-email-geert@linux-m68k.org>
 <20131213005322.GJ32101@verge.net.au>
Date: Fri, 13 Dec 2013 09:03:45 +0100
Message-ID: <CAMuHMdW8cSLXy36fD1QaSjHoFsM5B4ZK4JVwLY-OefX+wFOtiQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] kexec support for Linux/m68k (tools part)
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
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, kexec@lists.infradead.org

Hi Simon,

On Fri, Dec 13, 2013 at 1:53 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Oct 15, 2013 at 07:50:57PM +0200, Geert Uytterhoeven wrote:
>> kexec support for Linux/m68k (tools part)
>>
>> This is a set of patches to add kexec support for m68k to kexec-tools.
>>
>>   - Kexec only, no kdump support yet (do you have enough RAM to keep a
>>     crashdump kernel in memory at all times? ;-)
>
> Thanks, applied.

Thanks, I have queued the kernel counterpart for 3.14.

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
