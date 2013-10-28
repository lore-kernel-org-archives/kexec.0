Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VabPc-00009g-5o
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 01:14:32 +0000
Date: Mon, 28 Oct 2013 09:13:55 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 1/4] Add function get_bootparam
Message-ID: <20131028011355.GC4397@dhcp-16-126.nay.redhat.com>
References: <20131027040437.600278368@dhcp-16-126.nay.redhat.com>
 <20131027041230.864225266@dhcp-16-126.nay.redhat.com>
 <20131028003800.GG849@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131028003800.GG849@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: mjg59@srcf.ucam.org, kexec@lists.infradead.org, vgoyal@redhat.com, James.Bottomley@HansenPartnership.com, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, kexec@lists.fedoraproject.org

> > @@ -447,7 +446,7 @@ void setup_subarch(struct x86_linux_para
> >  	if (!debugfs_mnt)
> >  		return;
> >  	snprintf(filename, PATH_MAX, "%s/%s", debugfs_mnt, "boot_params/data");
> > -	filename[PATH_MAX-1] = 0;
> > +	filename[PATH_MAX - 1] = 0;
> >  	free(debugfs_mnt);
> 
> This change appears to be unrelated to the rest of the patch.
> 

Will remove the change from the patch.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
