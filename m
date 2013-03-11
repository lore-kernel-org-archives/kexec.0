Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UEqeX-0001sL-LE
 for kexec@lists.infradead.org; Mon, 11 Mar 2013 00:31:46 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id AE1833EE0AE
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2013 09:31:43 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9062945DD73
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2013 09:31:43 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7778445DE50
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2013 09:31:43 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 62D7E1DB8038
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2013 09:31:43 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 19FC0E08002
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2013 09:31:43 +0900 (JST)
Date: Mon, 11 Mar 2013 09:31:41 +0900 (JST)
Message-Id: <20130311.093141.331282420.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v2 01/20] vmcore: refer to e_phoff member explicitly
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <513C2C47.5020008@cn.fujitsu.com>
References: <20130302083554.31252.30615.stgit@localhost6.localdomain6>
 <5135A054.7010401@cn.fujitsu.com> <513C2C47.5020008@cn.fujitsu.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: zhangyanfei@cn.fujitsu.com
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, akpm@linux-foundation.org, cpw@sgi.com, vgoyal@redhat.com

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Subject: Re: [PATCH v2 01/20] vmcore: refer to e_phoff member explicitly
Date: Sun, 10 Mar 2013 14:46:31 +0800

> 于 2013年03月05日 15:35, Zhang Yanfei 写道:
>> 于 2013年03月02日 16:35, HATAYAMA Daisuke 写道:
<cut>
> 
> One minor suggestion.
> 
> Previously, when the code assumes program headers are following immediately
> the ELF header, it uses
> 
>  elfcorebuf_sz = sizeof(Elf64_Ehdr) + ehdr.e_phnum * sizeof(Elf64_Phdr);
> 
> to calculate the size of ELF header and ELF program headers
> 
> This patch avoids the assumption, and uses ehdr.e_phoff to get the program
> headers' address. But it will read unrelated contents into elfcorebuf if
> program headers are not following immediately the ELF header. So could the
> code be:
> 
> elfcorebuf_sz = sizeof(Elf64_Ehdr) + ehdr.e_phnum * sizeof(Elf64_Phdr);
> addr = elfcorehdr_addr + ehdr.e_phoff;
> memcpy(elfcorebuf, &ehdr, sizeof(Elf64_Ehdr));
> read_from_oldmem(elfcorebuf + sizeof(Elf64_Ehdr), elfcorebuf_sz -
>                  sizeof(Elf64_Ehdr), &addr, 0);
> (Elf64_Ehdr *)elfcorebuf->e_phoff = sizeof(Elf64_Ehdr);

Thanks. This is not minor suggestion. This is critical. My code is
completely broken. On ELF, segments and headers other than ELF header
can occur in any positions. This means program header table can occur
after segments. So, on terabyte systems, e_phoff can be more than
terabytes.

Sorry, this was due to my carelessness.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
