Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo185.gate.nec.co.jp ([114.179.232.185])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gNh6i-0002Tv-U3
 for kexec@lists.infradead.org; Fri, 16 Nov 2018 16:36:37 +0000
Received: from tyo161.gate.nec.co.jp (tyo161.gate.nec.co.jp [114.179.232.161])
 by tyo185.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id
 wAGGZMER032650
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Sat, 17 Nov 2018 01:35:22 +0900
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH v2 2/2] makedumpfile/x86_64: Add 'page_offset_base'
 reading capability from VMCOREINFO
Date: Fri, 16 Nov 2018 16:32:21 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03560D67@BPXM09GP.gisp.nec.co.jp>
References: <1540799431-11064-1-git-send-email-bhsharma@redhat.com>
 <1540799431-11064-3-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1540799431-11064-3-git-send-email-bhsharma@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: Bhupesh Sharma <bhsharma@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: Baoquan He <bhe@redhat.com>

Hi Bhupesh,

On 10/29/2018 3:50 AM, Bhupesh Sharma wrote:
> makedumpfile '--mem-usage' use-case is currently broken on x86_64 with
> latest kernels (see a sample log below with 4.19 kernel):
> 
> [root@hp-dl380pgen8-02-vm-15 ~]# makedumpfile -f --mem-usage /proc/kcore
>    The kernel version is not supported.
>    The makedumpfile operation may be incomplete.
>    <snip..>
>    set_kcore_vmcoreinfo: Can't get the offset of VMCOREINFO(/proc/kcore).
>    Success
> 
>    makedumpfile Failed.
> 
> It seems that the issue is seen because KCORE_REMAP which was added
> to recent kernels and appears as a PT_LOAD in '/proc/kcore'.

I'm a bit late, but as for this problem:

* Since kernel 4.19 itself doesn't have NUMBER(page_offset_base) in vmcoreinfo,
we need to merge the patch I sent in order to support kernel 4.19.
http://lists.infradead.org/pipermail/kexec/2018-October/021749.html

* It looks like the following commit already removed KCORE_REMAP PT_LOAD from
/proc/kcore at 4.20-rc1, and the problem doesn't occur with mainline kernel.

commit bf904d2762ee6fc1e4acfcb0772bbfb4a27ad8a6
Author: Andy Lutomirski <luto@kernel.org>
Date:   Mon Sep 3 15:59:44 2018 -0700

    x86/pti/64: Remove the SYSCALL64 entry trampoline
...
-       /*
-        * The cpu_entry_area alias addresses are not in the kernel binary
-        * so they do not show up in /proc/kcore normally.  This adds entries
-        * for them manually.
-        */
-       kclist_add_remap(&per_cpu(kcore_entry_trampoline, cpu),
-                        _entry_trampoline,
-                        &get_cpu_entry_area(cpu)->entry_trampoline, PAGE_SIZE);

But yes, kcore PT_LOADs seems changeable like this.

Thanks,
Kazu



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
