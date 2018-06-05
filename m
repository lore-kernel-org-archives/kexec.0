Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fQKa6-0006wv-3h
 for kexec@lists.infradead.org; Tue, 05 Jun 2018 22:37:35 +0000
Received: by mail-ua0-x242.google.com with SMTP id m21-v6so2805461uan.0
 for <kexec@lists.infradead.org>; Tue, 05 Jun 2018 15:37:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180601192545.GR4511@wotan.suse.de>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-8-git-send-email-zohar@linux.vnet.ibm.com>
 <20180601191545.GP4511@wotan.suse.de> <20180601192545.GR4511@wotan.suse.de>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 5 Jun 2018 15:37:22 -0700
Message-ID: <CAGXu5jKkg_=iHGgrED4qB4TCFJaWgLkLp61RHgJ6UEhAj89GwQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 7/8] ima: based on policy prevent loading firmware
 (pre-allocated buffer)
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Rik van Riel <riel@redhat.com>, Laura Abbott <labbott@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kexec Mailing List <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, linux-integrity <linux-integrity@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>, Vlastimil Babka <vbabka@suse.cz>, Andres Rodriguez <andresx7@gmail.com>

On Fri, Jun 1, 2018 at 12:25 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Fri, Jun 01, 2018 at 09:15:45PM +0200, Luis R. Rodriguez wrote:
>> On Tue, May 29, 2018 at 02:01:59PM -0400, Mimi Zohar wrote:
>> > Some systems are memory constrained but they need to load very large
>> > firmwares.  The firmware subsystem allows drivers to request this
>> > firmware be loaded from the filesystem, but this requires that the
>> > entire firmware be loaded into kernel memory first before it's provided
>> > to the driver.  This can lead to a situation where we map the firmware
>> > twice, once to load the firmware into kernel memory and once to copy the
>> > firmware into the final resting place.
>> >
>> > To resolve this problem, commit a098ecd2fa7d ("firmware: support loading
>> > into a pre-allocated buffer") introduced request_firmware_into_buf() API
>> > that allows drivers to request firmware be loaded directly into a
>> > pre-allocated buffer.  The QCOM_MDT_LOADER calls dma_alloc_coherent() to
>> > allocate this buffer.  According to Documentation/DMA-API.txt,
>> >
>> >      Consistent memory is memory for which a write by either the
>> >      device or the processor can immediately be read by the processor
>> >      or device without having to worry about caching effects.  (You
>> >      may however need to make sure to flush the processor's write
>> >      buffers before telling devices to read that memory.)
>> >
>> > Devices using pre-allocated DMA memory run the risk of the firmware
>> > being accessible by the device prior to the kernel's firmware signature
>> > verification has completed.
>>
>> Indeed. And since its DMA memory we have *no idea* what can happen in
>> terms of consumption of this firmware from hardware, when it would start
>> consuming it in particular.
>>
>> If the device has its own hardware firmware verification mechanism this is
>> completely obscure to us, but it may however suffice certain security policies.
>>
>> The problem here lies in the conflicting security policies of the kernel wanting
>> to not give away firmware until its complete and the current inability to enable
>> us to have platforms suggest they trust hardware won't do something stupid.
>> This becomes an issue since the semantics of the firmware API preallocated
>> buffer do not require currently allow the kernel to inform LSMs of the fact
>> that a buffer is DMA memory or not, and a way for certain platforms then
>> to say that such use is fine for specific devices.
>>
>> Given a pointer can we determine if a piece of memory is DMA or not?
>
> FWIW
>
> Vlastimil suggests page_zone() or virt_to_page() may be able to.

I don't see a PAGEFLAG for DMA, but I do see ZONE_DMA for
page_zone()... So maybe something like

struct page *page;

page = virt_to_page(address);
if (!page)
   fail closed...
if (page_zone(page) == ZONE_DMA)
    handle dma case...
else
    non-dma

But I've CCed Laura and Rik, who I always lean on when I have these
kinds of page questions...

-Kees

-- 
Kees Cook
Pixel Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
