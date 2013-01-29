Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ia0-x22d.google.com ([2607:f8b0:4001:c02::22d])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U00Va-0000b5-Gv
 for kexec@lists.infradead.org; Tue, 29 Jan 2013 02:01:11 +0000
Received: by mail-ia0-f173.google.com with SMTP id l29so5258374iag.32
 for <kexec@lists.infradead.org>; Mon, 28 Jan 2013 18:01:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <51072147.9090306@zytor.com>
References: <1358868049-19884-1-git-send-email-trenn@suse.de>
 <1358868049-19884-2-git-send-email-trenn@suse.de>
 <51072147.9090306@zytor.com>
Date: Mon, 28 Jan 2013 18:01:08 -0800
Message-ID: <CAE9FiQUZu4_wnJ+TZBqE_k+WxS6803r_i7LpOaCNY06xBGyWQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86 e820: Check for exactmap appearance when parsing
 first memmap option
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, Thomas Renninger <trenn@suse.de>, vgoyal@redhat.com

On Mon, Jan 28, 2013 at 5:09 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 01/22/2013 07:20 AM, Thomas Renninger wrote:
>> From: Yinghai Lu <yinghai@kernel.org>
>>
>> memmap=exactmap will throw away all original, but also until then
>> user defined (through other provided memmap= parameters) areas.
>> That means all memmap= boot parameters passed before a memmap=exactmap
>> parameter are not recognized.
>> Without this fix:
>> memmap=x@y memmap=exactmap memmap=i#k
>> only i#k would get recognized.
>>
>> This is wrong, this fix will only throw away all original e820 areas once
>> when memmap=exactmap is found in the whole boot command line and before
>> any other memmap= option is parsed.
>>
>
> I don't understand why this is wrong.  The kernel command line is always
> parsed from left to right, and I don't see anything inherently
> problematic with that with something like a big hammer like exactmap.

Ok, let's drop it.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
