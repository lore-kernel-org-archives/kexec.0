Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JofX0-0003Hi-58
	for kexec@lists.infradead.org; Wed, 23 Apr 2008 14:01:06 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20080422151622.43c85a00@strauss.suse.de>
	<e2ed954f0804221644y436bd6cdoeb1fed2fd5d04ccb@mail.gmail.com>
	<20080423103400.6e3d9d90@strauss.suse.de>
Date: Wed, 23 Apr 2008 07:00:57 -0700
In-Reply-To: <20080423103400.6e3d9d90@strauss.suse.de> (Bernhard Walle's
	message of "Wed, 23 Apr 2008 10:34:00 +0200")
Message-ID: <m163u8oeli.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: kexec --real-mode
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
Cc: kexec@lists.infradead.org, Jamey Sharp <jamey@thetovacompany.com>

Bernhard Walle <bwalle@suse.de> writes:

> * Jamey Sharp [2008-04-22 16:44]:
>>
>> On Tue, Apr 22, 2008 at 6:16 AM, Bernhard Walle <bwalle@suse.de> wrote:
>> > did anybody try the --real-mode option with current release? I tried
>> > it on two machines, and on one machine it just reboots, on the other
>> > machine it hangs.
>> 
>> I think you're experiencing a bug that I just proposed a patch for. :-)
>> You can confirm that: try adding the "--debug" option to your kexec
>> call. If that works correctly, then I think you'll find that the patch
>> in "[PATCH 2/9] Fix copy-paste bug: entry16 does not start at
>> entry16_debug" will solve your problem. That's archived here:
>> 
>> http://lists.infradead.org/pipermail/kexec/2008-April/001581.html
>
> No, I used --debug already.

If this used to work when booting older kernels on your hardware.
Jamey's patch 3/9 might help.

Otherwise if this is the first time you are trying it you may
simply have encountered the reason that --real-mode is not the default.
BIOS can get really strange after the kernel has been running.

When I had that the default I only had around a 50% success rate or
something like that.

You might try booting kexec_test and see where that puts you.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
