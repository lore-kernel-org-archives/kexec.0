Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIgcC-0005dK-CT
 for kexec@lists.infradead.org; Thu, 21 Mar 2013 14:37:13 +0000
Date: Thu, 21 Mar 2013 10:36:56 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 17/21] vmcore: check NT_VMCORE_PAD as a mark
 indicating the end of ELF note buffer
Message-ID: <20130321143656.GG3934@redhat.com>
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040223.15064.77472.stgit@localhost6.localdomain6>
 <87ppyvp014.fsf@xmission.com>
 <20130321.115920.339923125.d.hatayama@jp.fujitsu.com>
 <87r4j98l1q.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r4j98l1q.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, kumagai-atsushi@mxc.nes.nec.co.jp, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com

On Wed, Mar 20, 2013 at 08:54:25PM -0700, Eric W. Biederman wrote:

[..]
> > Also, it's possible to get size of a whole part of ELF note segments
> > from p_memsz or p_filesz, and gdb and binutils are reading the note
> > segments until reaching the size.
> 
> Agreed.  Except in our weird case where we generate the notes on the
> fly, and generate the NOTE segment header much earlier.

And in our case we don't know the size of ELF note. Kernel is not
exporting the size. So kexec-tools is putting an upper limit of 1024
and putting that value in p_memsz and p_filesz fields.

Given the fact that we are reserving elf notes at boot. That means
we know the size of ELF notes. It should make sense to export it
to user space and let kexec-tools put right values.

In fact looks like /sys/kernel/vmcoreinfo is exporting two values. Address
and size. (This is kind of violation of sysfs poilcy of one value per
file). But for per cpu notes, we are exporting only address and not
size.

/sys/devices/system/cpu/cpu<n>/crash_notes

May be we should export another file

/sys/devices/system/cpu/cpu<n>/crash_notes_size

and let kexec-tools parse it.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
