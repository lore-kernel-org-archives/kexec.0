Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bsLKG-0001Hi-4B
 for kexec@lists.infradead.org; Fri, 07 Oct 2016 02:55:56 +0000
Date: Fri, 7 Oct 2016 11:55:33 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/3] kexec elf: Sanity check on the note header before
 accessing it
Message-ID: <20161007025533.GF13721@verge.net.au>
References: <1472215576-7466-1-git-send-email-s.munaut@whatever-company.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1472215576-7466-1-git-send-email-s.munaut@whatever-company.com>
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
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: kexec@lists.infradead.org

On Fri, Aug 26, 2016 at 12:46:14PM +0000, Sylvain Munaut wrote:
> The name[hdr.n_namesz -1] check below can segfault if the header
> is garbage. So we check the computed header side fits within
> the expected area before going further.
> 
> Signed-off-by: Sylvain Munaut <s.munaut@whatever-company.com>

Thanks, I have applied this and the other two patches in this series.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
