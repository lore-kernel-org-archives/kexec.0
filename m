Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]
	helo=VA3EHSOBE003.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NVs8f-0003nk-V7
	for kexec@lists.infradead.org; Fri, 15 Jan 2010 19:47:25 +0000
Message-ID: <4B50C641.8020802@am.sony.com>
Date: Fri, 15 Jan 2010 11:47:13 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: Problems compiling kexec-tools
References: <BAY114-W49E2846C6D653AB15A9A03DD6C0@phx.gbl>,
	<4B4E029E.4020404@am.sony.com>
	<BAY114-W336F3329F5DE1A53218CC5DD690@phx.gbl>
In-Reply-To: <BAY114-W336F3329F5DE1A53218CC5DD690@phx.gbl>
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
To: Zitt Zitterkopf <zittware@hotmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 01/15/2010 10:47 AM, Zitt Zitterkopf wrote:
>> BTW, have you looked at the petitboot bootloader? For
>> the most part it is a better choice than kboot.
>> It provides essentially all the functionality that
>> kboot does, plus more, it is easier to build, and it
>> is a currently maintained project.
> 
> I do see some benefit for petitboot with the graphical menu. Ideally we'd need a version which reads each partition looking for multiple /boot kernels and present a method to select each one using a alpha char. Kinda like the old System Commander app.

Just FYI, petitboot is setup to receive hot plug events
(udev supported, hotplug-2 planned) and dhcp events.  It
looks on any storage devices for boot menu config files
and for any netboot info from dhcp and then adds or removes
boot menu items for those dynamically.

Petitboot does not look for kernel images it can boot,
as you need more than that to boot a kernel (initrd,
boot options, etc. are needed), nor does it test for
the existence of any images specified in boot config
files, as you would potentially need to be looking all
over the Internet for them, and waiting for network
timeouts, etc. just doesn't make sense.  Petitboot just
assumes the user keeps the configs in good order.

As for the 'one key' selection UI you mention, Petitboot is
setup with a client-server architecture.  The server deamon
is the thing that receives events, looks for config files,
parses the files, etc., then it sends the info to the client
UI apps.  Multilpe UI client apps can register with the
server, so you can say have one UI on the display, and
several running in telnet sessions.

Anyway, petitboot was designed for it to be relatively easy
to make a new custom UI app.  Your 'one key' selection
seems to be just a variation of the existing ncurses menu UI. 

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
