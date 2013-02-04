Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U2E32-0006Fh-5Z
 for kexec@lists.infradead.org; Mon, 04 Feb 2013 04:52:53 +0000
Message-ID: <510F3E93.9080708@zytor.com>
Date: Sun, 03 Feb 2013 20:52:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kdump: do not drop entire e820 in crash kernel
References: <E1U2DId-0001E4-Df@eag09.americas.sgi.com>
In-Reply-To: <E1U2DId-0001E4-Df@eag09.americas.sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>

On 02/03/2013 08:04 PM, Cliff Wickman wrote:
> From: Cliff Wickman <cpw@sgi.com>
>
> The crash kernel is not able to find its root device if that device is not
> on PCI 0.
>
> This is because it is booted with the command line option memmap=exactmap
> which currently clears the e820 table.  So ACPI processing does not
> find reserved i/o spaces.
>
> This works for a device on PCI 0 because ACPI falls back to a legacy mode.
> But the error message " [Firmware Bug]: PCI: MMCONFIG at
>   [mem 0x80000000-0x80cfffff] not reserved in ACPI motherboard resources"
> is written to the log even in this functioning case.
>
> It fails for some devices on UV2, and only for UV2, because SGI seems to
> be the only manufacturer currently using the extended PCI(>0).
>
> The fix is to not drop the entire e820 table on a memmap=exactmap, but
> to preserve all the non-E820_RAM reservations that the BIOS has made.
>

NAK.  This is a fundamntal semantic change to  something that isn't just 
affecting kexec.

This ultimately is the result of the very bad design decision to use the 
command line to muck with the target kernel memory map.

The work is underway to fix this, but this is not the right fix.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
