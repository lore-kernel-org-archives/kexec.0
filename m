Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYQwK-0005NT-Pm
 for kexec@lists.infradead.org; Fri, 11 Apr 2014 02:11:37 +0000
Date: Fri, 11 Apr 2014 10:11:10 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH v5 05/10] x86, cleanup: use dbgprint_mem_range for memory
 range debugging
Message-ID: <20140411021110.GB2944@dhcp-17-89.nay.redhat.com>
References: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
 <1397121186-9353-6-git-send-email-chaowang@redhat.com>
 <20140410201858.GH18298@oranje.fc.hp.com>
 <20140411020021.GB5493@dhcp-16-198.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140411020021.GB5493@dhcp-16-198.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, Linn Crosetto <linn@hp.com>, hpa@zytor.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

On 04/11/14 at 10:00am, Dave Young wrote:
> > Is the definition for dbgprint_mem_range() missing? It was added in patch v4 1/4
> > but I do not see it in this set.
> 
> I think that one has been merged by Simon..

Yes, Simon has picked up this one.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
