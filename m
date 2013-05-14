Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UcHcP-0002St-EG
 for kexec@lists.infradead.org; Tue, 14 May 2013 15:58:26 +0000
Date: Tue, 14 May 2013 11:57:55 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 5/8] vmcore: allocate ELF note segment in the 2nd
 kernel vmalloc memory
Message-ID: <20130514155755.GH13674@redhat.com>
References: <20130514015622.18697.77191.stgit@localhost6.localdomain6>
 <20130514015734.18697.32447.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130514015734.18697.32447.stgit@localhost6.localdomain6>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com, jingbai.ma@hp.com

On Tue, May 14, 2013 at 10:57:35AM +0900, HATAYAMA Daisuke wrote:

[..]
> +/* Merges all the PT_NOTE headers into one. */
> +static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
> +					   char **notesegptr, size_t *notesegsz,
> +					   struct list_head *vc_list)
> +{

Given that we are copying notes in second kernel, we are not using vc_list
in merge_note_headers() any more. So remove vc_list from paramter list
here.

For local parameters we could simply use notes_buf (instead of notesgptr)
and notes_sz (instead of notesgsz). It seems mroe readable.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
