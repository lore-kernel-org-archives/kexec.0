Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TtlrF-0008VZ-GU
 for kexec@lists.infradead.org; Fri, 11 Jan 2013 21:09:46 +0000
Received: by mail-bk0-f46.google.com with SMTP id q16so1182868bkw.33
 for <kexec@lists.infradead.org>; Fri, 11 Jan 2013 13:09:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50F070D8.2080109@zytor.com>
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
 <201301111333.49238.trenn@suse.de>
 <CAE9FiQWPJdER++ZrkKx7cQpF0QvwBeghNjpFqK18pMNC0w20tw@mail.gmail.com>
 <1603289.LXteBtkifD@hammer82.arch.suse.de>
 <CAE9FiQU6RWH6cBKc9th3Eb2gCjcHfotbC1sYspQ7dU+cG=VMFA@mail.gmail.com>
 <50F070D8.2080109@zytor.com>
Date: Fri, 11 Jan 2013 13:09:43 -0800
Message-ID: <CAE9FiQWEan4Vq-pbp6sgMWVFHwWygQ4Hq2wRsPH166+7w7L2yg@mail.gmail.com>
Subject: Re: [PATCH] x86 e820: only void usable memory areas in
 memmap=exactmap case
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
Cc: horms@verge.net.au, Takao Indoh <indou.takao@jp.fujitsu.com>, MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>, tokunaga.keiich@jp.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, Thomas Renninger <trenn@suse.de>, vgoyal@redhat.com, khalid@gonehiking.org

On Fri, Jan 11, 2013 at 12:06 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 01/11/2013 11:59 AM, Yinghai Lu wrote:
>> On Fri, Jan 11, 2013 at 10:24 AM, Thomas Renninger <trenn@suse.de> wrote:
>>>> We may need to keep exactmap intact.
>>> Why?
>>> Kexec/kdump should have been the only user?
>>> If older/current kexec calls still add ACPI maps via memmap=X#Y,
>>> they should already exist in the original e820 map and fall off or
>>> get glued to one region if (wrongly) overlapping via sanitize_map.
>>
>> No, kexec/kdump is not the only user for memmap=exactmap.
>>
>
> Who is using it then, since you seem to know?

http://forums.gentoo.org/viewtopic-t-487476-highlight-proliant.html

http://forums.fedoraforum.org/archive/index.php/t-225347.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
