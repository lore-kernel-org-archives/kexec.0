Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Txjam-0008DA-H2
 for kexec@lists.infradead.org; Tue, 22 Jan 2013 19:33:09 +0000
Received: by mail-ie0-f179.google.com with SMTP id k14so12186824iea.38
 for <kexec@lists.infradead.org>; Tue, 22 Jan 2013 11:33:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1358868049-19884-2-git-send-email-trenn@suse.de>
References: <1358868049-19884-1-git-send-email-trenn@suse.de>
 <1358868049-19884-2-git-send-email-trenn@suse.de>
Date: Tue, 22 Jan 2013 11:33:06 -0800
Message-ID: <CAE9FiQXHG_HMuQK=d+vOXNokZnZ1eSmU+V2_50zuWvtJ=ayEWA@mail.gmail.com>
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
To: Thomas Renninger <trenn@suse.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, hpa@zytor.com, vgoyal@redhat.com

On Tue, Jan 22, 2013 at 7:20 AM, Thomas Renninger <trenn@suse.de> wrote:
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

Actually I put this patch already in for-x86-boot branch.

http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commit;h=bd40ee79abf2351109ebd469b0b9ba6a8f3b0872

And will update change log to following to merge two change log.

---
Subject: [PATCH] x86: Handle multiple exactmaps and out of order exactmap

Current code expect that we only have one exactmap and exactmap need to
first one in memmap=.

memmap=exactmap will throw away all original entries, but also until
then user defined (through other provided memmap= parameters) areas.
That means all memmap= boot parameters passed before a memmap=exactmap
parameter are not recognized.

Without this fix:
        memmap=x@y memmap=exactmap memmap=i#k
only i#k would get recognized.  This is wrong.

This fix will scan the boot_command_line to find if there is exactmap at
first and only throw away all original e820 entries once, and then parse
other memmap= option.

-v2: incorporate change log from Thomas Renninger.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Reviewed-by: Thomas Renninger <trenn@suse.de>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
