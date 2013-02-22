Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8iSg-0003cH-Dg
 for kexec@lists.infradead.org; Fri, 22 Feb 2013 02:34:11 +0000
Message-ID: <5126D90D.4080603@oracle.com>
Date: Thu, 21 Feb 2013 21:33:49 -0500
From: Sasha Levin <sasha.levin@oracle.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: prevent double free on image allocation failure
References: <1361496375-30994-1-git-send-email-sasha.levin@oracle.com>
 <87vc9l5cz4.fsf@xmission.com>
In-Reply-To: <87vc9l5cz4.fsf@xmission.com>
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
To: ebiederm@xmission.com
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On 02/21/2013 08:55 PM, ebiederm@xmission.com wrote:
> Sasha Levin <sasha.levin@oracle.com> writes:
> 
>> If kimage_normal_alloc() fails to initialize an allocated kimage, it will free
>> the image but would still set 'rimage', as a result kexec_load will try
>> to free it again.
>>
>> This would explode as part of the freeing process is accessing internal
>> members which point to uninitialized memory.
> 
> Agreed.
> 
> I don't think that failure path has ever actually been exercised.

trinity is actually quite good at hitting that, which is how I discovered
it:

[  418.138251] Could not allocate control_code_buffer
[  418.143739] general protection fault: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
[  418.147131] Dumping ftrace buffer:
[  418.147901]    (ftrace buffer empty)
[  418.148697] Modules linked in:
[  418.153440] CPU 1
[  418.153440] Pid: 18098, comm: trinity Tainted: G        W    3.8.0-next-20130220-sasha-00037-gc07b3b2-dirty #7
[  418.153440] RIP: 0010:[<ffffffff8119b5a6>]  [<ffffffff8119b5a6>] kimage_free_page_list+0x16/0x50
[  418.153440] RSP: 0018:ffff88009bfade78  EFLAGS: 00010292
[  418.153440] RAX: 0000000000180004 RBX: 0000000000000002 RCX: 0000000000000000
[  418.153440] RDX: ffff88009c1a0000 RSI: 0000000000000001 RDI: 6b6b6b6b6b6b6b6b
[  418.153440] RBP: ffff88009bfade98 R08: 0000000000002782 R09: 0000000000000000
[  418.153440] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88009c6cb4d0
[  418.153440] R13: ffff88009c6cb720 R14: ffff88009c6cb4d0 R15: 00000000000000f6
[  418.153440] FS:  00007fb7eb95b700(0000) GS:ffff8800bb800000(0000) knlGS:0000000000000000
[  418.153440] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  418.153440] CR2: 00000000004808e0 CR3: 000000009eaaa000 CR4: 00000000000406e0
[  418.153440] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  418.153440] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  418.153440] Process trinity (pid: 18098, threadinfo ffff88009bfac000, task ffff88009c1a0000)
[  418.153440] Stack:
[  418.153440]  ffffffff8546e948 0000000000000002 ffff88009c6cb4d0 0000000000000000
[  418.153440]  ffff88009bfaded8 ffffffff8119b60f 0000000000000002 0000000000000002
[  418.153440]  ffff88009c6cb4d0 ffff88009c6cb4d0 fffffffffffffff4 00000000000000f6
[  418.153440] Call Trace:
[  418.153440]  [<ffffffff8119b60f>] kimage_free+0x2f/0x100
[  418.153440]  [<ffffffff8119c563>] sys_kexec_load+0x593/0x660
[  418.153440]  [<ffffffff8118363d>] ? trace_hardirqs_on+0xd/0x10
[  418.153440]  [<ffffffff83dab7d8>] tracesys+0xe1/0xe6
[  418.153440] Code: c1 ef 0c 55 48 c1 e7 06 48 89 e5 48 01 c7 e8 82 ff ff ff 5d c3 55 48 89 e5 41 55 49 89 fd 41 54 53 48 83 ec
08 48 8b 3f 49 39 fd <48> 8b 1f 75 08 eb 22 0f 1f 00 48 89 d3 4c 8d 67 e0 e8 54 a6 8a
[  418.153440] RIP  [<ffffffff8119b5a6>] kimage_free_page_list+0x16/0x50
[  418.153440]  RSP <ffff88009bfade78>
[  418.219646] ---[ end trace 0adb1d6b71fefb29 ]---


Thanks,
Sasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
