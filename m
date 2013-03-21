Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIYjK-0007Am-LQ
 for kexec@lists.infradead.org; Thu, 21 Mar 2013 06:12:03 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040053.15064.93652.stgit@localhost6.localdomain6>
 <87ppyvnjyn.fsf@xmission.com>
 <20130321.115041.225288996.d.hatayama@jp.fujitsu.com>
Date: Wed, 20 Mar 2013 23:11:48 -0700
In-Reply-To: <20130321.115041.225288996.d.hatayama@jp.fujitsu.com> (HATAYAMA
 Daisuke's message of "Thu, 21 Mar 2013 11:50:41 +0900 (JST)")
Message-ID: <87r4j92sez.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 01/21] vmcore: reference e_phoff member explicitly to
 get position of program header table
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

> From: "Eric W. Biederman" <ebiederm@xmission.com>
> Subject: Re: [PATCH v3 01/21] vmcore: reference e_phoff member explicitly to get position of program header table
> Date: Tue, 19 Mar 2013 14:44:16 -0700
>
>> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:
>> 
>>> Currently, the code assumes that position of program header table is
>>> next to ELF header. But future change can break the assumption on
>>> kexec-tools and the 1st kernel. To avoid worst case, reference e_phoff
>>> member explicitly to get position of program header table in
>>> file-offset.
>> 
>> In principle this looks good.  However when I read this it looks like
>> you are going a little too far.
>> 
>> You are changing not only the reading of the supplied headers, but
>> you are changing the generation of the new new headers that describe
>> the data provided by /proc/vmcore.
>> 
>> I get lost in following this after you mangle merge_note_headers.
>> 
>> In principle removing silly assumptions seems reasonable, but I think
>> it is completely orthogonal to the task of maping vmcore mmapable.
>> 
>> I think it is fine to claim that the assumptions made here in vmcore are
>> part of the kexec on panic ABI at this point, which would generally make
>> this change unnecessary.
>
> This was suggested by Vivek. He prefers generic one.
>
> Vivek, do you agree to this? Or is it better to re-post this and other
> clean-up patches as another one separately to this patch set?

My deep problem with this patch was that you were changing how we think
about the generated headers, and that just didn't seem to make any
sense, and certainly it seems to be orthogonal from the patch itself.

For headers that we generate it is perfectly fine to make all kinds of
assumptions.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
