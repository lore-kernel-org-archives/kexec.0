Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1eCbWh-0008Q8-I9
 for kexec@lists.infradead.org; Thu, 09 Nov 2017 01:21:05 +0000
Date: Thu, 9 Nov 2017 10:20:16 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [Patch resend] vmcore-dmesg: avoid allocating large memory chunk
 for log buf
Message-ID: <20171109012016.ltq4wgddj6vvjvkk@verge.net.au>
References: <20171108000331.8640-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171108000331.8640-1-xiyou.wangcong@gmail.com>
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
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: panand@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org

On Tue, Nov 07, 2017 at 04:03:31PM -0800, Cong Wang wrote:
> In kdump kernel, we got:
> 
>     Saving vmcore-dmesg.txt
>     Failed to malloc 67108864 bytes for the logbuf: Cannot allocate memory
> 
> Apparently 64M is too luxury for a kdump kernel which only has 128M
> in total.
> 
> We can avoid allocating such a large memory chunk, instead just allocate
> a smaller chunk inside the loop each time.
> 
> Verify the result by comparing the vmcore-dmesg output with and without
> this patch.
> 
> Cc: Simon Horman <horms@verge.net.au>
> Reviewed-by: Dave Young <dyoung@redhat.com>
> Reviewed-by: Pratyush Anand <panand@redhat.com>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
