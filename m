Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LVKI2-0001yR-Su
	for kexec@lists.infradead.org; Fri, 06 Feb 2009 06:34:15 +0000
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id n166WcnJ026448
	for <kexec@lists.infradead.org>; Fri, 6 Feb 2009 17:32:38 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n166YSIA975030
	for <kexec@lists.infradead.org>; Fri, 6 Feb 2009 17:34:28 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n166YAA9004779
	for <kexec@lists.infradead.org>; Fri, 6 Feb 2009 17:34:10 +1100
From: Chandru <chandru@in.ibm.com>
Subject: Re: [PATCH] powerpc: initialize drconf variables
Date: Fri, 6 Feb 2009 12:04:08 +0530
References: <200902042146.28854.chandru@in.ibm.com>
	<200902041748.56793.bwalle@suse.de>
In-Reply-To: <200902041748.56793.bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200902061204.08433.chandru@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

On Wednesday 04 February 2009 22:18:56 Bernhard Walle wrote:
> * Chandru [2009-02-04 17:16:28]:
> >
> > +	strcpy(fname, "/proc/device-tree/");
> > +	strcat(fname, "ibm,dynamic-reconfiguration-memory/ibm,lmb-size");
> > +	if ((file = fopen(fname, "r")) == NULL) {
> > +		perror(fname);
> > +		return -1;
> > +	}
> > +	if (fread(buf, 1, 8, file) < 0) {
> 
>     fread(buf, 1, 8, file) != 8
> 
> >  	}
> > +	/* first 4 bytes tell the number of lmbs */
> > +	if (fread(buf, 1, 4, file) < 0) {
> 
>     fread(buf, 1, 4, file) != 4 


Thanks for pointing out the correction Bernhard. I will update the patch
and send it again.

Thanks,
Chandru


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
