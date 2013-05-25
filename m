Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ug4kO-0003T9-Ob
 for kexec@lists.infradead.org; Sat, 25 May 2013 03:02:21 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1369400889-11064-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130524143644.GD18218@redhat.com> <20130524170626.2ac06efe@holzheu>
 <20130524152849.GF18218@redhat.com> <87mwrkatgu.fsf@xmission.com>
 <51A006CF.90105@gmail.com>
Date: Fri, 24 May 2013 20:01:36 -0700
In-Reply-To: <51A006CF.90105@gmail.com> (Zhang Yanfei's message of "Sat, 25
 May 2013 08:33:19 +0800")
Message-ID: <87k3mnahkf.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kdump/mmap: Fix mmap of /proc/vmcore for s390
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

Zhang Yanfei <zhangyanfei.yes@gmail.com> writes:

> Hello Eric,
>
>> The function copy_oldmem_page also concerns me.  I don't have a clue why
>> we duplicate that function on every architecutre in a slightly different
>> form.  There should be enough abstractions in the kernel to make that
>> unnecessary.  I would be glad to see that function go, and remove the
>> possibility of confusion that happened on s390.
>
> You mean we should have a common copy_oldmem_page for all architectures? And
> just like vivek said above, for s390, we should put the swap info in the elf
> headers instead of doing that in copy_oldmem_page.

Exactly.

The user space change in /sbin/kexec should even be backwards compatible
for s390.  So fixing /sbin/kexec should probably come first.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
