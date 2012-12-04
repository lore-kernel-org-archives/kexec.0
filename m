Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TfmWx-0002wH-MP
 for kexec@lists.infradead.org; Tue, 04 Dec 2012 07:03:00 +0000
Message-ID: <50BDA016.2070404@zytor.com>
Date: Mon, 03 Dec 2012 23:02:46 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/5] kexec: put bzImage and ramdisk above 4G for x86
 64bit
References: <1354140594-3686-1-git-send-email-yinghai@kernel.org>
 <20121204054709.GB15969@verge.net.au>
In-Reply-To: <20121204054709.GB15969@verge.net.au>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Haren Myneni <hbabu@us.ibm.com>, Yinghai Lu <yinghai@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org

On 12/03/2012 09:47 PM, Simon Horman wrote:
> Hi Everyone,
>
> there was some healthy discussion around the previous versions
> of this series, but so far none on this version. Have we reached
> consensus?
>

No, we haven't converged on the boot protocol yet and just respinning 
the patch set doesn't change that.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
