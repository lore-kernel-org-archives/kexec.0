Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LUkvu-0005uI-G7
	for kexec@lists.infradead.org; Wed, 04 Feb 2009 16:49:05 +0000
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 0625845748
	for <kexec@lists.infradead.org>; Wed,  4 Feb 2009 17:48:58 +0100 (CET)
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] powerpc: initialize drconf variables
Date: Wed, 4 Feb 2009 17:48:56 +0100
References: <200902042146.28854.chandru@in.ibm.com>
In-Reply-To: <200902042146.28854.chandru@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200902041748.56793.bwalle@suse.de>
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
To: kexec@lists.infradead.org

* Chandru [2009-02-04 17:16:28]:
>
> +	strcpy(fname, "/proc/device-tree/");
> +	strcat(fname, "ibm,dynamic-reconfiguration-memory/ibm,lmb-size");
> +	if ((file = fopen(fname, "r")) == NULL) {
> +		perror(fname);
> +		return -1;
> +	}
> +	if (fread(buf, 1, 8, file) < 0) {

    fread(buf, 1, 8, file) != 8

>  	}
> +	/* first 4 bytes tell the number of lmbs */
> +	if (fread(buf, 1, 4, file) < 0) {

    fread(buf, 1, 4, file) != 4 


Regards,
Bernhard


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
