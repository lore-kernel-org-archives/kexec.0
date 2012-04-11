Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]
 helo=am1outboundpool.messaging.microsoft.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SHugR-0007Ry-5g
 for kexec@lists.infradead.org; Wed, 11 Apr 2012 10:21:51 +0000
Date: Wed, 11 Apr 2012 12:21:37 +0200
From: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH 0/4] Export offsets of VMCS fields as note information
 for kdump
Message-ID: <20120411102136.GG2428@amd.com>
References: <4F84E0DF.8040206@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F84E0DF.8040206@cn.fujitsu.com>
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
To: zhangyanfei <zhangyanfei@cn.fujitsu.com>
Cc: dzickus@redhat.com, luto@mit.edu, gregkh@suse.de, kvm@vger.kernel.org, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, avi@redhat.com, ebiederm@xmission.com

Hi,

On Wed, Apr 11, 2012 at 09:39:43AM +0800, zhangyanfei wrote:
> The problem is that VMCS internal is hidden by Intel in its
> specification. So, we reverse engineering it in the way implemented in
> this patch set.

Have you made sure this layout is the same on all uarchitectures that
implment VMX?


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
