Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ud4rP-00056q-6l
 for kexec@lists.infradead.org; Thu, 16 May 2013 20:33:12 +0000
Date: Thu, 16 May 2013 16:32:36 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v6 6/8] vmcore: allocate ELF note segment in the 2nd
 kernel vmalloc memory
Message-ID: <20130516203236.GG5904@redhat.com>
References: <20130515090507.28109.28956.stgit@localhost6.localdomain6>
 <20130515090614.28109.26492.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130515090614.28109.26492.stgit@localhost6.localdomain6>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: riel@redhat.com, hughd@google.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, kosaki.motohiro@jp.fujitsu.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, walken@google.com, cpw@sgi.com, jingbai.ma@hp.com

On Wed, May 15, 2013 at 06:06:14PM +0900, HATAYAMA Daisuke wrote:

[..]

> +static int __init get_note_number_and_size_elf32(const Elf32_Ehdr *ehdr_ptr,
> +						 int *nr_ptnote, u64 *phdr_sz)
> +{
> +	return process_note_headers_elf32(ehdr_ptr, nr_ptnote, phdr_sz, NULL);
> +}
> +
> +static int __init copy_notes_elf32(const Elf32_Ehdr *ehdr_ptr, char *notes_buf)
> +{
> +	return process_note_headers_elf32(ehdr_ptr, NULL, NULL, notes_buf);
> +}
> +

Please don't do this. We need to create two separate functions doing
two different operations and not just create wrapper around a function
which does two things.

I know both functions will have similar for loops for going through
the elf notes but it is better then doing function overloading based
on parameters passed.

Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
