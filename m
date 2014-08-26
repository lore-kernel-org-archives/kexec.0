Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XMHUk-0007RF-VO
 for kexec@lists.infradead.org; Tue, 26 Aug 2014 14:13:11 +0000
Date: Tue, 26 Aug 2014 22:12:44 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [Patch v3 7/7] add a new interface to show the memory usage of
 1st kernel
Message-ID: <20140826141244.GA1809@dhcp-17-102.nay.redhat.com>
References: <1406535606-16303-1-git-send-email-bhe@redhat.com>
 <1406535606-16303-8-git-send-email-bhe@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97246623@BPXM01GP.gisp.nec.co.jp>
 <20140821103126.GA6517@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9724F9CA@BPXM01GP.gisp.nec.co.jp>
 <20140826032247.GA6230@dhcp-16-105.nay.redhat.com>
 <20140826082534.5b070f7d@hananiah.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140826082534.5b070f7d@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 08/26/14 at 08:25am, Petr Tesarik wrote:
> On Tue, 26 Aug 2014 11:22:47 +0800
> "bhe@redhat.com" <bhe@redhat.com> wrote:
> 
> >[...]
> > Here it use lseek to position, then try to read, and then reading failed
> > and raised a SIGKILL.
> > 
> > lseek(3, 8799381360640, SEEK_SET)       = 8799381360640
> > read(3,  <unfinished ...>
> > +++ killed by SIGKILL +++
> > Killed
> 
> This smells like killed by OOM Killer. Can you check the kernel log if
> there's anything?

Thanks for notice, it is caused by kernel addr validation check in
read_kcore. No idea why it happened.

[ +35.288439] BUG: unable to handle kernel paging request at
ffff8800c4000000
[  +0.011559] IP: [<ffffffff8105870b>] kern_addr_valid+0x15b/0x1b0
[  +0.010586] PGD 220f067 PUD 2213067 PMD 80000000c4000062 
[  +0.009994] Oops: 0000 [#1] SMP 
[  +0.007782] Modules linked in: xt_CHECKSUM nf_conntrack_netbios_ns
nf_conntrack_broadcast ipt_MASQUERADE ip6t_REJECT xt_conntrack cfg80211
rfki
[  +0.084041] CPU: 2 PID: 1679 Comm: makedumpfile Not tainted 3.17.0-rc2
#15
[  +0.012249] Hardware name: Dell Inc. PowerEdge T105 /0J001K, BIOS
1.4.4 07/30/2009
[  +0.012991] task: ffff8800c010ae40 ti: ffff880214830000 task.ti:
ffff880214830000
[  +0.012886] RIP: 0010:[<ffffffff8105870b>]  [<ffffffff8105870b>]
kern_addr_valid+0x15b/0x1b0
[  +0.013860] RSP: 0018:ffff880214833e88  EFLAGS: 00010206
[  +0.010710] RAX: 00000000c4000000 RBX: 0000000000001000 RCX:
0000000000000000
[  +0.012445] RDX: 00000000c4000000 RSI: ffff880000000000 RDI:
80000000c4000062
[  +0.012298] RBP: ffff880214833e88 R08: 000000000000000e R09:
00007fffffffffff
[  +0.012322] R10: 0000000000000001 R11: 0000000000000246 R12:
0000000000001000
[  +0.012316] R13: 00000000022beb10 R14: ffff880214833f50 R15:
ffff8800c4000000
[  +0.012308] FS:  00007f0c91ffa740(0000) GS:ffff88022fd00000(0000)
knlGS:0000000000000000
[  +0.013315] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.010985] CR2: ffff8800c4000000 CR3: 000000021a632000 CR4:
00000000000007e0
[  +0.012266] Stack:
[  +0.006976]  ffff880214833ee0 ffffffff81255c38 ffff880214929410
0000000000000000
[  +0.012471]  0000000d14833ed8 0000000000001000 ffff880223c7c480
00000000022beb10
[  +0.012465]  ffff880214833f50 0000000000001000 00007ffffe1840c0
ffff880214833f00
[  +0.012456] Call Trace:
[  +0.007459]  [<ffffffff81255c38>] read_kcore+0x228/0x300
[  +0.010392]  [<ffffffff8124962d>] proc_reg_read+0x3d/0x80
[  +0.010491]  [<ffffffff811e58f8>] vfs_read+0x98/0x170
[  +0.010153]  [<ffffffff811e6576>] SyS_read+0x46/0xb0
[  +0.010034]  [<ffffffff8111d5f6>] ? __audit_syscall_exit+0x1f6/0x2a0
[  +0.011425]  [<ffffffff8181dea9>] system_call_fastpath+0x16/0x1b
[  +0.011072] Code: 48 89 f8 66 66 66 90 48 be 00 f0 ff ff ff 3f 00 00
48 c1 ea 09 48 21 f0 81 e2 f8 0f 00 00 48 be 00 00 00 00 00 88 ff ff 48
01
[  +0.030537] RIP  [<ffffffff8105870b>] kern_addr_valid+0x15b/0x1b0
[  +0.011666]  RSP <ffff880214833e88>
[  +0.009043] CR2: ffff8800c4000000
[  +0.042194] ---[ end trace 97512601fec12186 ]---

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
