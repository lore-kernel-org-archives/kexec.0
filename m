Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ud7tc-0003Hq-KI
 for kexec@lists.infradead.org; Thu, 16 May 2013 23:47:41 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 095D23EE0B6
 for <kexec@lists.infradead.org>; Fri, 17 May 2013 08:47:19 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id EAB1645DE51
 for <kexec@lists.infradead.org>; Fri, 17 May 2013 08:47:18 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id D298A45DE4F
 for <kexec@lists.infradead.org>; Fri, 17 May 2013 08:47:18 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id C248F1DB803E
 for <kexec@lists.infradead.org>; Fri, 17 May 2013 08:47:18 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 794751DB8037
 for <kexec@lists.infradead.org>; Fri, 17 May 2013 08:47:18 +0900 (JST)
Message-ID: <51956FF6.3070205@jp.fujitsu.com>
Date: Fri, 17 May 2013 08:47:02 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 6/8] vmcore: allocate ELF note segment in the 2nd kernel
 vmalloc memory
References: <20130515090507.28109.28956.stgit@localhost6.localdomain6>
 <20130515090614.28109.26492.stgit@localhost6.localdomain6>
 <20130516203236.GG5904@redhat.com>
In-Reply-To: <20130516203236.GG5904@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: riel@redhat.com, hughd@google.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, kosaki.motohiro@jp.fujitsu.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, walken@google.com, cpw@sgi.com, jingbai.ma@hp.com

(2013/05/17 5:32), Vivek Goyal wrote:
> On Wed, May 15, 2013 at 06:06:14PM +0900, HATAYAMA Daisuke wrote:
>
> [..]
>
>> +static int __init get_note_number_and_size_elf32(const Elf32_Ehdr *ehdr_ptr,
>> +						 int *nr_ptnote, u64 *phdr_sz)
>> +{
>> +	return process_note_headers_elf32(ehdr_ptr, nr_ptnote, phdr_sz, NULL);
>> +}
>> +
>> +static int __init copy_notes_elf32(const Elf32_Ehdr *ehdr_ptr, char *notes_buf)
>> +{
>> +	return process_note_headers_elf32(ehdr_ptr, NULL, NULL, notes_buf);
>> +}
>> +
>
> Please don't do this. We need to create two separate functions doing
> two different operations and not just create wrapper around a function
> which does two things.
>
> I know both functions will have similar for loops for going through
> the elf notes but it is better then doing function overloading based
> on parameters passed.
>

I see. This part must be fixed in the next version.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
