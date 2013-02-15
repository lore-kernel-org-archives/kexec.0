Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U6Na8-0002zB-VQ
 for kexec@lists.infradead.org; Fri, 15 Feb 2013 15:52:13 +0000
Date: Fri, 15 Feb 2013 10:52:09 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 08/13] vmcore: remove unused helper function
Message-ID: <20130215155209.GG27784@redhat.com>
References: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
 <20130214101227.22466.12503.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130214101227.22466.12503.stgit@localhost6.localdomain6>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, cpw@sgi.com

On Thu, Feb 14, 2013 at 07:12:27PM +0900, HATAYAMA Daisuke wrote:
> Remove map_offset_to_paddr(), which is no longer used.

This along with how read logic is changed should be one patch. And
on top of it should be second patch which reads some part of memory
from current kernel instead of old kernel.

Thanks
Vivek

> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
> 
>  fs/proc/vmcore.c |   21 ---------------------
>  1 files changed, 0 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 4125a65..3aedb52 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -117,27 +117,6 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
>  	return read;
>  }
>  
> -/* Maps vmcore file offset to respective physical address in memroy. */
> -static u64 map_offset_to_paddr(loff_t offset, struct list_head *vc_list,
> -					struct vmcore **m_ptr)
> -{
> -	struct vmcore *m;
> -	u64 paddr;
> -
> -	list_for_each_entry(m, vc_list, list) {
> -		u64 start, end;
> -		start = m->offset;
> -		end = m->offset + m->size - 1;
> -		if (offset >= start && offset <= end) {
> -			paddr = m->paddr + offset - start;
> -			*m_ptr = m;
> -			return paddr;
> -		}
> -	}
> -	*m_ptr = NULL;
> -	return 0;
> -}
> -
>  /* Read from the ELF header and then the crash dump. On error, negative value is
>   * returned otherwise number of bytes read are returned.
>   */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
