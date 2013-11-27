Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlnRV-0003G1-9F
 for kexec@lists.infradead.org; Wed, 27 Nov 2013 22:18:45 +0000
Message-ID: <52966FA1.3020606@oracle.com>
Date: Wed, 27 Nov 2013 15:18:09 -0700
From: Khalid Aziz <khalid.aziz@oracle.com>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: Clear Bus Master bit only on kexec reboot
References: <1385579908-24608-1-git-send-email-khalid.aziz@oracle.com>
 <87ob55my8z.fsf@xmission.com> <52964F2C.1020803@oracle.com>
 <20131127212227.GA31237@kroah.com> <20131127215309.GA15320@srcf.ucam.org>
 <20131127220106.GA21887@kroah.com> <20131127220704.GA15609@srcf.ucam.org>
In-Reply-To: <20131127220704.GA15609@srcf.ucam.org>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: cl91tp@gmail.com, gnomes@lxorguk.ukuu.org.uk, indou.takao@jp.fujitsu.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, f.otti@gmx.at, khlebnikov@openvz.org, "Eric W. Biederman" <ebiederm@xmission.com>, jility09@gmail.com, bhelgaas@google.com, tianyu.lan@intel.com

On 11/27/2013 03:07 PM, Matthew Garrett wrote:
> On Wed, Nov 27, 2013 at 02:01:06PM -0800, Greg KH wrote:
>> Anyway, I really don't care either way, but this seems like something
>> that the drivers should be doing.  What suddenly changed that caused
>> this problem to occur that hasn't happened in the years prior to now
>> that drives this to be a stable-kernel issue?
>
> We started clearing the busmaster bit on all devices on shutdown in
> 3.something in order to ensure that DMA wasn't occuring while we were
> in the process of performing a kexec. Some machines freeze on shutdown
> as a result. This patch reverts back to the original behaviour on real
> shutdown, while still avoiding the "This PCI device scribbled over my
> new kernel" kexec case.
>

Thanks for explaining this, Matthew. That was my reasoning exactly for 
why this patch should apply to stable. It fixes a real problem some 
users are experiencing. Commit log contains the URL to bugzilla entry 
for the problem.

--
Khalid

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
