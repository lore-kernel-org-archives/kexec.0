Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-mw2nam10on2129.outbound.protection.outlook.com
 ([40.107.94.129] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKPpK-009p9f-ED
 for kexec@lists.infradead.org; Thu, 11 Mar 2021 18:14:28 +0000
From: Joe LeVeque <jolevequ@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH] kexec: Add kexec reboot string
Date: Thu, 11 Mar 2021 18:14:19 +0000
Message-ID: <MWHPR21MB047848DAF9A5D35FEC1EC6D5DA909@MWHPR21MB0478.namprd21.prod.outlook.com>
References: <20210304124626.13927-1-pmenzel@molgen.mpg.de>
 <20210310213258.da50fe5f81086ab0147f6167@linux-foundation.org>
In-Reply-To: <20210310213258.da50fe5f81086ab0147f6167@linux-foundation.org>
Content-Language: en-US
MIME-Version: 1.0
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
To: Andrew Morton <akpm@linux-foundation.org>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Eric Biederman <ebiederm@xmission.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guohan Lu <lguohan@gmail.com>

Hi Andrew,

Is this all your looking for? If not, please let me know.

> Signed-off-by: Joe LeVeque <jolevequ@microsoft.com>

Thanks,
Joe

-----Original Message-----
From: Andrew Morton <akpm@linux-foundation.org> 
Sent: Wednesday, March 10, 2021 9:33 PM
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Eric Biederman <ebiederm@xmission.com>; kexec@lists.infradead.org; linux-kernel@vger.kernel.org; Guohan Lu <lguohan@gmail.com>; Joe LeVeque <jolevequ@microsoft.com>
Subject: [EXTERNAL] Re: [PATCH] kexec: Add kexec reboot string

On Thu,  4 Mar 2021 13:46:26 +0100 Paul Menzel <pmenzel@molgen.mpg.de> wrote:

> From: Joe LeVeque <jolevequ@microsoft.com>
> 
> The purpose is to notify the kernel module for fast reboot.
> 
> Upstream a patch from the SONiC network operating system [1].
> 
> [1]: 
> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgith
> ub.com%2FAzure%2Fsonic-linux-kernel%2Fpull%2F46&amp;data=04%7C01%7Cjol
> evequ%40microsoft.com%7Cddd7ea68d7d14ecdbd6608d8e44f225b%7C72f988bf86f
> 141af91ab2d7cd011db47%7C1%7C0%7C637510375952624615%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C1000&amp;sdata=0lxaoVz%2BYyu5C4HvzSGMf0NpJJUWZFWdp7m3hLlL9MM%3D&am
> p;reserved=0
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

We should have Joe's signed-off-by: for this.  Joe, can you please send it?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
