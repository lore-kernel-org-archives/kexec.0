Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIq3W-0004yg-My
 for kexec@lists.infradead.org; Fri, 22 Mar 2013 00:42:03 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130321.115920.339923125.d.hatayama@jp.fujitsu.com>
 <87r4j98l1q.fsf@xmission.com> <20130321143656.GG3934@redhat.com>
 <20130322.093042.393566604.d.hatayama@jp.fujitsu.com>
Date: Thu, 21 Mar 2013 17:41:51 -0700
In-Reply-To: <20130322.093042.393566604.d.hatayama@jp.fujitsu.com> (HATAYAMA
 Daisuke's message of "Fri, 22 Mar 2013 09:30:42 +0900 (JST)")
Message-ID: <87r4j8p8og.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 17/21] vmcore: check NT_VMCORE_PAD as a mark indicating
 the end of ELF note buffer
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com, vgoyal@redhat.com

HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:

> From: Vivek Goyal <vgoyal@redhat.com>
> Subject: Re: [PATCH v3 17/21] vmcore: check NT_VMCORE_PAD as a mark indicating the end of ELF note buffer
> Date: Thu, 21 Mar 2013 10:36:56 -0400
>
>> And in our case we don't know the size of ELF note. Kernel is not
>> exporting the size. So kexec-tools is putting an upper limit of 1024
>> and putting that value in p_memsz and p_filesz fields.
>> 
>> Given the fact that we are reserving elf notes at boot. That means
>> we know the size of ELF notes. It should make sense to export it
>> to user space and let kexec-tools put right values.
>> 
>
> Anyway, I think of this issue as beyond the scope of what I'm working
> here...

Agreed.  It is independent and can be fixed independently.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
