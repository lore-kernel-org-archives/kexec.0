Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tzzhp-00061I-SB
 for kexec@lists.infradead.org; Tue, 29 Jan 2013 01:09:46 +0000
Message-ID: <51072147.9090306@zytor.com>
Date: Mon, 28 Jan 2013 17:09:27 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] x86 e820: Check for exactmap appearance when parsing
 first memmap option
References: <1358868049-19884-1-git-send-email-trenn@suse.de>
 <1358868049-19884-2-git-send-email-trenn@suse.de>
In-Reply-To: <1358868049-19884-2-git-send-email-trenn@suse.de>
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
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, yinghai@kernel.org, vgoyal@redhat.com

On 01/22/2013 07:20 AM, Thomas Renninger wrote:
> From: Yinghai Lu <yinghai@kernel.org>
> 
> memmap=exactmap will throw away all original, but also until then
> user defined (through other provided memmap= parameters) areas.
> That means all memmap= boot parameters passed before a memmap=exactmap
> parameter are not recognized.
> Without this fix:
> memmap=x@y memmap=exactmap memmap=i#k
> only i#k would get recognized.
> 
> This is wrong, this fix will only throw away all original e820 areas once
> when memmap=exactmap is found in the whole boot command line and before
> any other memmap= option is parsed.
> 

I don't understand why this is wrong.  The kernel command line is always
parsed from left to right, and I don't see anything inherently
problematic with that with something like a big hammer like exactmap.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
