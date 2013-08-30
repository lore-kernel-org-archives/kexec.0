Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VFQry-0003GB-Me
 for kexec@lists.infradead.org; Fri, 30 Aug 2013 15:44:19 +0000
Message-ID: <5220BDBC.2060807@linux.intel.com>
Date: Fri, 30 Aug 2013 08:43:56 -0700
From: "H. Peter Anvin" <hpa@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] x86, apic: Disable BSP if boot cpu is AP
References: <20130829092458.5476.10277.stgit@localhost6.localdomain6>
 <521F5297.4070906@linux.intel.com> <521FDE8D.4040807@jp.fujitsu.com>
In-Reply-To: <521FDE8D.4040807@jp.fujitsu.com>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org, jingbai.ma@hp.com

On 08/29/2013 04:51 PM, HATAYAMA Daisuke wrote:
> 
> This is not a regression just as Eric explains.
> 
> There is also my explanation in the description of the 2nd patch. I
> should have described so here explicitly.
> 

OK.  We're probably days away from a merge window, so I would like to
put this in the queue for 3.13.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
